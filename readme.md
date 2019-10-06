# Welcome to Movies App!

Here's a brief description about how to start the app:
> Before starting the app please check out the api folders and files structure to understand the app.

## Run migrations 

To run migrations you have to run the command on your terminal
`sequel -m db/migrations your_db_connection_string`
There is an example for this command using sqlite3
`sequel -m db/migrations sqlite//mydb.db`

> You can skip this step because starting the app will run all pending migrations

## Start the app

To start this app you have to run the command on your terminal
> If you are located at the root of the project you have to do it as follows
first run `cd gateway` and then `rackup`

> If you are located at the gateway folder you have to do it as follows
just run `rackup`


# Api folter struct

```
gateway
│   README.md
│     
│
└─── api
│     └───   models
│     	 		└─ model_folder
│   	  			└─ contract_file.rb
│     		 		└─ model_file.rb
│     └───  operations
│     			└─ model_operation_folder
│     				└─ create.rb
│     				└─ delete.rb
│     				└─ list.rb
│     				└─ update.rb
│     └───  views 
|			  └─ base_file
|			  └─ viewset1
|			  └─ viewset2
│	 
└─── app
└─── config
└─── db
└─── test
```
