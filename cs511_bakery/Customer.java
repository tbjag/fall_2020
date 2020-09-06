import java.util.List;
import java.util.ArrayList;
import java.util.Random;
import java.util.Arrays;

public class Customer {
    private Random rnd;
    private List<BreadType> items;
    private int shopTime;
    private int checkoutTime;

    public Customer() {
        this.rnd = new Random();
        items = new ArrayList<BreadType>();
        shopTime = 100 + rnd.nextInt(800);
        checkoutTime = 100 + rnd.nextInt(500);
        chooseItems();
    }

    public boolean addItem(BreadType item) {
        if (items.size() >= 3) {
            return false;
        }
        items.add(item);
        return true;
    }

    public List<BreadType> getItems() {
        return items;
    }

    public int getShopTime() {
        return shopTime;
    }

    public int getCheckoutTime() {
        return checkoutTime;
    }

    public String toString() {
        return "Customer " + hashCode() + ": items=" + Arrays.toString(items.toArray()) + ", shopTime=" + shopTime + ", checkoutTime=" + checkoutTime;
    }

    private void chooseItems() {
        int itemCnt = 1 + rnd.nextInt(3);
        while (itemCnt > 0) {
            addItem(BreadType.values()[rnd.nextInt(BreadType.values().length)]);
            itemCnt--;
        }
    }

    public static void main(String[] args) {
        Customer[] customers = new Customer[5];
        for (int i = 0; i < customers.length; ++i) {
            customers[i] = new Customer();
            customers[i].chooseItems();
        }
        for (int i = 0; i < customers.length; ++i) {
            System.out.println(customers[i].toString());
        }
    }
}