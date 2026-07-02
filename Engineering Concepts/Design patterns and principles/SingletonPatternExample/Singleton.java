class Logger {
    private static Logger instance;

    //private constructor
    private Logger() {
        System.out.println("Logger Instance Created");
    }

    public static Logger getInstance() {

        if (instance == null) {
            instance = new Logger();
        }

        return instance;
    }
}

// Test class
class Singleton
{
    public static void main(String[] args)
    {
        Logger logger1= Logger.getInstance();
        Logger logger2= Logger.getInstance();

        System.out.println("Logger 1 : "+logger1);
        System.out.println("Logger 2 : "+logger2);

        //Check whether both logger1 and logger2 are same
        System.out.println(logger1==logger2);
    }
}