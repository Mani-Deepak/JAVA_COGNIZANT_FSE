-- Scenario 1
DECLARE

    CURSOR customer_cursor IS
        SELECT
            C.CustomerID,
            TRUNC(MONTHS_BETWEEN(SYSDATE, C.DOB)/12) AS AGE,
            L.InterestRate
        FROM Customers C
        JOIN Loans L
        ON C.CustomerID = L.CustomerID;

BEGIN
    FOR customer IN customer_cursor LOOP

        IF customer.AGE > 60 THEN

            UPDATE Loans
            SET InterestRate = InterestRate - (InterestRate * 0.01)
            WHERE CustomerID = customer.CustomerID;

        END IF;

    END LOOP;

END;
/


--Scenario 2

--first add a column caller isVIP to the customers table
ALTER TABLE Customers
ADD IsVIP VARCHAR2(5);

DECLARE

    CURSOR customer_cursor IS
        SELECT CustomerID, Balance
        FROM Customers;

BEGIN

    FOR customer IN customer_cursor LOOP

        IF customer.Balance > 10000 THEN

            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = customer.CustomerID;

        ELSE

            UPDATE Customers
            SET IsVIP = 'FALSE'
            WHERE CustomerID = customer.CustomerID;

        END IF;

    END LOOP;
END;
/

--verification
SELECT CustomerID,
       Name,
       Balance,
       IsVIP
FROM Customers;


--Scenario 3

DECLARE

    CURSOR loan_cursor IS
        SELECT C.Name,L.EndDate
        FROM Customers C
        JOIN Loans L
        ON C.CustomerID = L.CustomerID;

BEGIN

    FOR customer IN loan_cursor LOOP
        IF customer.EndDate - SYSDATE <= 30 THEN
            DBMS_OUTPUT.PUT_LINE('Reminder: Dear '|| customer.Name|| ', your loan is due on '|| customer.EndDate);
        END IF;
    END LOOP;

END;
/
