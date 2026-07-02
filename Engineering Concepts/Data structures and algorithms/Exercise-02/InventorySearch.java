import java.util.*;

class Product {
    int productId;
    String productName;
    String category;

    Product(int productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }
}

class InventorySearch {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        System.out.println("Enter the number of products:");
        int count = sc.nextInt();
        sc.nextLine(); // Consume the leftover newline

        Product[] products = new Product[count];

        for (int i = 0; i < count; i++) {

            System.out.println("Enter Product ID:");
            int id = sc.nextInt();
            sc.nextLine(); // Consume newline

            System.out.println("Enter Product Name:");
            String name = sc.nextLine();

            System.out.println("Enter Product Category:");
            String category = sc.nextLine();

            products[i] = new Product(id, name, category);
        }

        System.out.println("Enter Product ID to search:");
        int targetId = sc.nextInt();

        // Linear Search
        Product p1 = linearSearch(products, targetId);

        if (p1 == null) {
            System.out.println("Product not found using Linear Search.");
        } else {
            System.out.println("Product found using Linear Search:");
            System.out.println("ID: " + p1.productId);
            System.out.println("Name: " + p1.productName);
            System.out.println("Category: " + p1.category);
        }

        // Sort array before Binary Search
        Arrays.sort(products, Comparator.comparingInt(p -> p.productId));

        // Binary Search
        Product p2 = binarySearch(products, targetId);

        if (p2 == null) {
            System.out.println("Product not found using Binary Search.");
        } else {
            System.out.println("Product found using Binary Search:");
            System.out.println("ID: " + p2.productId);
            System.out.println("Name: " + p2.productName);
            System.out.println("Category: " + p2.category);
        }

        System.out.println("Both searches returned the same object: " + (p1 == p2));
    }

    public static Product linearSearch(Product[] products, int targetId) {

        for (Product p : products) {
            if (p.productId == targetId) {
                return p;
            }
        }

        return null;
    }

    public static Product binarySearch(Product[] products, int targetId) {

        int low = 0;
        int high = products.length - 1;

        while (low <= high) {

            int mid = low + (high - low) / 2;

            if (products[mid].productId == targetId) {
                return products[mid];
            }

            else if (products[mid].productId < targetId) {
                low = mid + 1;
            }

            else {
                high = mid - 1;
            }
        }

        return null;
    }
}