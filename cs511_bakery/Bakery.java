import java.util.Arrays;
import java.util.Random;
import java.util.Map;
import java.util.HashMap;
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Semaphore;

public class Bakery implements Runnable {
    private static final int TOTAL_CUSTOMERS = 20; // 1000
    private static final int ALLOWED_CUSTOMERS = 5; // 50
    private static final int FULL_BREAD = 3; // 100
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
        availableBread = new HashMap<BreadType, Integer>();
        availableBread.put(BreadType.RYE, FULL_BREAD);
        availableBread.put(BreadType.SOURDOUGH, FULL_BREAD);
        availableBread.put(BreadType.WONDER, FULL_BREAD);
        Arrays.fill(semBreadStand, new Semaphore(1));

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
                    System.out.println("Customer " + c.hashCode() + " acquires bakery entry");
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
                            int breadLeft = availableBread.get(item);
                            if (breadLeft > 0) {
                                availableBread.put(item, breadLeft - 1);
                            } else {
                                System.out.println("No " + item.toString() + " bread left! Restocking...");
                                // restock by acquiring the bread stand for some time
                                Thread.sleep(2000);
                                availableBread.put(item, FULL_BREAD - 1);
                            }
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
