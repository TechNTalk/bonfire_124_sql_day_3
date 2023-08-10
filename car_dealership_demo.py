# First step: Import libraries
from dotenv import load_dotenv # This is how we will pull the .env file into this file
from os import getenv # This is used to connect to the .env file
import psycopg2 # This is used to connect to the database

# Step 2: We will load the .env file
# Since the .env file is in the same directory, I just need to use the load_dotenv() method
load_dotenv()

# Step 3: Create a class
class PGSQL:
    #Step 3a: Create a user, password, and server variable by accessing the .env file
    # We will keep these items as a secret under our class by using the __ method
    #You keep the info a secret to keep others from gaining accessing to the sensitive info
    __user = getenv("DB")
    __password = getenv("PASSWORD")
    __server = getenv("SERVER")

    # Step 3b: Connect and access the database:
    # You want to have this under the thunder method so you will keep the connection secured
    __pg_con = psycopg2.connect( # This is the driver for Python to connect to PostgreSQL
    dbname = __user,
    user = __user,
    password = __password,
    host = __server
    )
   # Step 3c: Create a cursor object:
    # Consider this as a mouse, after connecting with the database, we need a way to interact with the connection that we made with PostgrSQL
    __cur = __pg_con.cursor()

    # Step 5: 
    def create_tables(self, sql_filepath: str):
       # use the static method to create a string of the sql commands we wrote earlier
       # Since each statement has its own semicolon at the end, we can use that to send each one as its own separate string
       start = self.create_file(sql_filepath)

       # Split based off the end of our query
       tables = start.split(';')

       # Iterate through a list of queries
       for table in tables:
          try: 
             print(table)
             # Execute the SQL Command
             self.__cur.execute(table)
             # Commit the changes to the database
             self.__pg_con.commit() # Think of this as GitHub, that once the changes have been made, we are uploading it to the database. This will be done at the end of each statement
             # Except statement to catch any errors from psycopg2
          except psycopg2.ProgrammingError as msg: #This will enable me to catch the error so the user doesn't see them and this provide clear language to clearly define what step we skipped over
             # Print the message that we skipped over
             print(f"Command Skipped: {msg}")
    def insert_data(self, sql_filepath: str):
       start = self.create_file(sql_filepath)
       data_to_insert = start.split(";")
       for insert in data_to_insert:
          try:
             print(insert)
             self.__cur.execute(insert)
             self.__pg_con.commit()
          except psycopg2.ProgrammingError as msg:
             print(f'Command Skipped: {msg}\n{insert}')
    # Step 4: Create static method
    @staticmethod # Using the static method allows me to access this UDF throughout the entirety of the class
    # All we have to do is use self. and access this function instead of having to create the function again later on
    # Below is an example of how we can call on the create_file function with the staticmethod by calling on it as a method when calling it to another class
    #     c = Class()
    # c.create_file()
    def create_file(filepath: str):
        """Opens a file by the filepath and apply it to a SQL Server"""
        with open(filepath, 'r') as f:
          sql_file = f.read()
          return sql_file  
    # The @staticmethod will be great for this function because we won't have to type this function out every time for the other functions and we can use the static method to access the same function anytime
if __name__ =='__main__':
   c = PGSQL()
   c.create_tables('/Users/investmentguy/Documents/coding_temple/bonfire_124_sql_day_1/bonfire_124_sql_day_3/car_dealership_create.sql')
#    c.insert_data("bonfire_124_sql_day_2/movie_theater_insert.sql")