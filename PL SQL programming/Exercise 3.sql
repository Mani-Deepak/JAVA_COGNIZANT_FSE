-- Stored Procedures


--Scenario 1
--Question: Write a stored procedure ProcessMonthlyInterest 
--that calculates and updates the balance of all savings accounts 
--by applying an interest rate of 1% to the current balance.

--Creating a procedure
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
    --Apply 1% interest rate 
    UPDATE Accounts SET Balance=(Balance+(0.01*Balance)) WHERE AccountType='Savings';
END;
/

--Calling Procedure

BEGIN
    ProcessMonthlyInterest;
END;
/


--Scenario 2
-- Question: Write a stored procedure UpdateEmployeeBonus that 
--updates the salary of employees in a given department 
--by adding a bonus percentage passed as a parameter.

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    --as we are having only 2 departments HR, IT I am using VARCHAR(2)
    dept IN VARCHAR2,
    bonus IN NUMBER
)
IS

BEGIN
    UPDATE Employees SET Salary=(Salary+(bonus/100)*Salary) WHERE Department=dept;
    COMMIT;
END;
/

--CALLING PROCEDURE

BEGIN
    --Add bonus of 5% salary to the employees working in HR department
    UpdateEmployeeBonus('HR',5);
END;
/

--VERIFICATION
SELECT * FROM Employees WHERE Department='HR';



--Scenario 3

-- Question: Write a stored procedure TransferFunds that 
-- transfers a specified amount from one account to another, 
-- checking that the source account has sufficient balance 
-- before making the transfer.


CREATE OR REPLACE PROCEDURE TransferFunds(
    sourceCustomerID IN NUMBER,
    receiverCustomerID IN NUMBER,
      amount IN NUMBER
)
IS
    sourceBalance NUMBER;
    sourceAccountID NUMBER;
    receiverAccountID NUMBER;
    transactionID NUMBER;

BEGIN

    -- Get Source Account ID to insert into transactions table after sucessful transaction
    SELECT AccountID, Balance
    INTO sourceAccountID, sourceBalance
    FROM Accounts
    WHERE CustomerID = sourceCustomerID;

    -- Get Receiver Account ID to insert into transactions table after sucessful transaction

    SELECT AccountID
    INTO receiverAccountID
    FROM Accounts
    WHERE CustomerID = receiverCustomerID;

   
    --Get Source account balance
    SELECT Balance INTO SourceBalance FROM CUSTOMERS WHERE sourceCustomerID=CustomerID;


    -- Check Balance first to proceed with the transaction
    IF sourceBalance >= amount THEN
        -- Update Customer Balance
        UPDATE Customers
        SET Balance = Balance - amount
        WHERE CustomerID = sourceCustomerID;

        UPDATE Customers
        SET Balance = Balance + amount
        WHERE CustomerID = receiverCustomerID;

        -- Update Account Balance
        UPDATE Accounts
        SET Balance = Balance - amount
        WHERE AccountID = sourceAccountID;

        UPDATE Accounts
        SET Balance = Balance + amount
        WHERE AccountID = receiverAccountID;


        -- Generate Next Transaction ID
        SELECT NVL(MAX(TransactionID),0)
        INTO transactionID
        FROM Transactions;

        -- Sender Transaction
        INSERT INTO Transactions(
            TransactionID,
            AccountID,
            TransactionDate,
            Amount,
            TransactionType
        )
        VALUES(
            transactionID + 1,
            sourceAccountID,
            SYSDATE,
            amount,
            'Withdrawal'
        );

        -- Receiver Transaction
        INSERT INTO Transactions(
            TransactionID,
            AccountID,
            TransactionDate,
            Amount,
            TransactionType
        )
        VALUES(
            transactionID + 2,
            receiverAccountID,
            SYSDATE,
            amount,
            'Deposit'
        );

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Transfer Successful.');

    ELSE

        DBMS_OUTPUT.PUT_LINE('Insufficient Balance.');

    END IF;

END;
/


-- CALLING PROCEDURE

BEGIN
    --Transfer an amount of 500 from customer with id 1 to customer with id 2
    TransferFunds(1,2,500);
END;
/


--VERIFICATION
SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM TRANSACTIONS;

