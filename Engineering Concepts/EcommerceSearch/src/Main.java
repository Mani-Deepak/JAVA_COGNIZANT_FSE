import java.util.Arrays;

public class Main {
    public static Product linearSearch(Product[] products, int targetId) {
        for (Product product : products) {
            if (product.getProductId() == targetId) {
                return product;
            }
        }
        return null;
    }

    public static Product binarySearch(Product[] products, int targetId) {
        int left = 0;
        int right = products.length - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (products[mid].getProductId() == targetId) {
                return products[mid];
            }
            if (products[mid].getProductId() < targetId) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null;
    }

    public static void main(String[] args) {
        Product[] products = {
            new Product(101, "Laptop", "Electronics"),
            new Product(102, "Smartphone", "Electronics"),
            new Product(103, "Shoes", "Apparel"),
            new Product(104, "Watch", "Accessories")
        };
        
        Arrays.sort(products);
        
        Product foundLinear = linearSearch(products, 103);
        System.out.println("Linear Search: " + (foundLinear != null ? foundLinear.getProductName() : "Not Found"));
        
        Product foundBinary = binarySearch(products, 102);
        System.out.println("Binary Search: " + (foundBinary != null ? foundBinary.getProductName() : "Not Found"));
    }
}
