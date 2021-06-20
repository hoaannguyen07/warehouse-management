Create Tables in this order:
1. personnel
2. permissions
3. rows
4. columns
5. levels
6. types
7. personnel_permissions
8. palettes
9. locations

THIS PARTICULAR ORDER IS CHOSEN TO ENSURE THAT 
TABLES WITH FOREIGN KEYS LINKING TO THEM ARE 
CREATED BEFORE THE FOREIGN KEYS ARE CREATED 
AS TO NOT CAUSE ANY ERRORS