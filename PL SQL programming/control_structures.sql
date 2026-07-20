-- PL/SQL Script for Exercise 1: Control Structures

-- Scenario 1: Apply a 1% discount to loan interest rates for customers above 60 years old.
DECLARE
    CURSOR c_customer_loans IS
        SELECT l.LoanID, l.InterestRate, c.DOB, c.Name
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID;
    
    v_age NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Running Scenario 1: Age-Based Interest Discount ---');
    FOR r_loan IN c_customer_loans LOOP
        -- Calculate age in years
        v_age := MONTHS_BETWEEN(SYSDATE, r_loan.DOB) / 12;
        
        IF v_age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE LoanID = r_loan.LoanID;
            
            DBMS_OUTPUT.PUT_LINE('Discount applied for ' || r_loan.Name || 
                                 ' (Age: ' || ROUND(v_age) || '). New Interest Rate: ' || 
                                 (r_loan.InterestRate - 1) || '%');
        END IF;
    END LOOP;
    COMMIT;
END;
/

-- Scenario 2: Promote a customer to VIP status based on their balance.
DECLARE
    CURSOR c_customers IS
        SELECT CustomerID, Name, Balance
        FROM Customers;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Running Scenario 2: VIP Status Promotion ---');
    FOR r_cust IN c_customers LOOP
        IF r_cust.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = r_cust.CustomerID;
            
            DBMS_OUTPUT.PUT_LINE('Customer ' || r_cust.Name || 
                                 ' promoted to VIP (Balance: $' || r_cust.Balance || ')');
        END IF;
    END LOOP;
    COMMIT;
END;
/

-- Scenario 3: Send reminders to customers whose loans are due within the next 30 days.
DECLARE
    CURSOR c_due_loans IS
        SELECT l.LoanID, c.Name, l.EndDate
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Running Scenario 3: Loan Due Reminders ---');
    FOR r_due IN c_due_loans LOOP
        DBMS_OUTPUT.PUT_LINE('REMINDER: Hello ' || r_due.Name || 
                             ', your Loan ID: ' || r_due.LoanID || 
                             ' is due on ' || TO_CHAR(r_due.EndDate, 'YYYY-MM-DD') || 
                             '. Please arrange for repayment.');
    END LOOP;
END;
/
