-- PL/SQL Script for Exercise 3: Stored Procedures

-- Scenario 1: Stored procedure to process monthly interest for savings accounts
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
    UPDATE Accounts
    SET Balance = Balance * 1.01,
        LastModified = SYSDATE
    WHERE AccountType = 'Savings';
    
    DBMS_OUTPUT.PUT_LINE('Savings accounts monthly 1% interest processed successfully.');
    COMMIT;
END;
/

-- Scenario 2: Stored procedure to update employee salary by adding a bonus percentage
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    p_dept VARCHAR2,
    p_bonus_percent NUMBER
) AS
BEGIN
    UPDATE Employees
    SET Salary = Salary * (1 + p_bonus_percent / 100)
    WHERE Department = p_dept;
    
    DBMS_OUTPUT.PUT_LINE('Bonus of ' || p_bonus_percent || '% updated for department: ' || p_dept);
    COMMIT;
END;
/

-- Scenario 3: Stored procedure to transfer funds between accounts
CREATE OR REPLACE PROCEDURE TransferFunds(
    p_source_acc NUMBER,
    p_dest_acc NUMBER,
    p_amount NUMBER
) AS
    v_source_bal NUMBER;
BEGIN
    -- 1. Check if source account exists and get balance
    SELECT Balance INTO v_source_bal 
    FROM Accounts 
    WHERE AccountID = p_source_acc;
    
    -- 2. Validate sufficient balance
    IF v_source_bal < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in the source account.');
    END IF;
    
    -- 3. Perform transfer (Debit source, Credit destination)
    UPDATE Accounts 
    SET Balance = Balance - p_amount, LastModified = SYSDATE
    WHERE AccountID = p_source_acc;
    
    UPDATE Accounts 
    SET Balance = Balance + p_amount, LastModified = SYSDATE
    WHERE AccountID = p_dest_acc;
    
    DBMS_OUTPUT.PUT_LINE('Transfer of $' || p_amount || ' from Account ' || 
                         p_source_acc || ' to Account ' || p_dest_acc || ' completed successfully.');
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: One or both account IDs do not exist.');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Transfer failed: ' || SQLERRM);
        ROLLBACK;
END;
/
