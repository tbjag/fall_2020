import java.util.Arrays;
import java.util.Random;
import java.util.Map;
import java.util.HashMap;
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Semaphore;

public class Bakery implements Runnable {
    private static final int TOTAL_CUSTOMERS = 10; // 1000
    private static final int ALLOWED_CUSTOMERS = 3; // 50
    private Map<BreadType, Integer> availableBread;
    private ExecutorService executor;

    // bakery w. allowed customers permits
    private final Semaphore semBakery = new Semaphore(ALLOWED_CUSTOMERS);

    // 3 bread stands
    private final Semaphore[] semBreadStand = new Semaphore[3];

    // 3 cashiers
    private final Semaphore semCashier = new Semaphore(3);

    /**
     * Run all customer threads, utilizing semaphores, as a fixed thread pool
     */
    public void run() {
        // setup
        Arrays.fill(semBreadStand, new Semaphore(1));
        availableBread = new HashMap<BreadType, Integer>();
        availableBread.put(BreadType.RYE, 500);
        availableBread.put(BreadType.SOURDOUGH, 500);
        availableBread.put(BreadType.WONDER, 500);
        semBreadStand[0] = new Semaphore(availableBread.get(BreadType.RYE));
        semBreadStand[1] = new Semaphore(availableBread.get(BreadType.SOURDOUGH));
        semBreadStand[2] = new Semaphore(availableBread.get(BreadType.WONDER));

        // generate customers and execute thread pool
        executor = Executors.newFixedThreadPool(TOTAL_CUSTOMERS);
        Customer[] customers = new Customer[TOTAL_CUSTOMERS];

        for (int i = 0; i < customers.length; ++i) {
            customers[i] = new Customer();
            // System.out.println(customers[i].toString());
        }

        executor.execute(new Runnable() {
            public void run() {
                // customer enters bakery, chooses items, checks out, leaves bakery

                for (Customer c : customers) {
                    // acquire entry to bakery
                    System.out.println("Customer " + c.hashCode() + " acquires bakery");
                    try {
                        semBakery.acquire();
                    } catch (InterruptedException ie) {
                        ie.printStackTrace();
                    }
                    
                    // acquire bread stands
                    for (BreadType item : c.getItems()) {
                        System.out.println("Customer " + c.hashCode() + " acquires " + item.toString() + " bread stand");
                        try {
                            semBreadStand[item.ordinal()].acquire();
                        } catch (InterruptedException ie) {
                            ie.printStackTrace();
                        }

                        System.out.println("Customer " + c.hashCode() + " shops for " + c.getShopTime() + " ms");
                        try {
                            Thread.sleep(c.getShopTime());
                        } catch (InterruptedException ie) {
                            ie.printStackTrace();
                        }
                        
                        System.out.println("Customer " + c.hashCode() + " releases " + item.toString() + " bread stand");
                        semBreadStand[item.ordinal()].release();
                    }

                    // acquire cashier
                    System.out.println("Customer " + c.hashCode() + " acquires cashier");
                    try {
                        semCashier.acquire();
                    } catch (InterruptedException ie) {
                        ie.printStackTrace();
                    }
                    
                    System.out.println("Customer " + c.hashCode() + " checks out for " + c.getCheckoutTime() + " ms");
                    try {
                        Thread.sleep(c.getCheckoutTime());
                    } catch (InterruptedException ie) {
                        ie.printStackTrace();
                    }
                    
                    System.out.println("Customer " + c.hashCode() + " releases cashier");
                    semCashier.release();

                    // leave bakery
                    System.out.println("Customer " + c.hashCode() + " releases bakery");
                    semBakery.release();
                }

            }
        });

        executor.shutdown();
    }
}
