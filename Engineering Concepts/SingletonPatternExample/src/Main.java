public class Main {
    public static void main(String[] args) {
        Logger logger1 = Logger.getInstance();
        Logger logger2 = Logger.getInstance();
        if (logger1 == logger2) {
            System.out.println("Both logger instances are the same. Singleton pattern works.");
        } else {
            System.out.println("Singleton pattern failed.");
        }
    }
}
