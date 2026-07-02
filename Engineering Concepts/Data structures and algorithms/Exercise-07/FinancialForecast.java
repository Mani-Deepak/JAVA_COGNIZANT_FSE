import java.util.Scanner;

class FinancialForecast {

    public static double predictFutureValue(double currentValue,double growthRate,int years) 
                                            {
        // Base Case
        if(years == 0)
            return currentValue;

        // Recursive Call
        return predictFutureValue(
                currentValue * (1 + growthRate),
                growthRate,
                years - 1
        );
    }

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        System.out.print("Enter Current Value: ");
        double currentValue = sc.nextDouble();

        System.out.print("Enter Growth Rate (%): ");
        double growthRate = sc.nextDouble() / 100;

        System.out.print("Enter Number of Years: ");
        //Considering only future, so taking +ve value for years
        int years = Math.max(0,sc.nextInt());

        double future =predictFutureValue(currentValue,growthRate,years);

        //display future value upto 2 decimals
        System.out.printf("Future Value = %.2f", future);

    }
}