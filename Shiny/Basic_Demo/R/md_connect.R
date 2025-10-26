

md_connect <- function(config_env = 'default') {
    
    #config <- config::get(config = config_env)
    token <- Sys.getenv("MD_TOKEN")
    
    conn <- DBI::dbConnect(duckdb::duckdb(), ":memory:")
    
    # Authenticate with MotherDuck Token 
    DBI::dbExecute(conn, "INSTALL motherduck")
    DBI::dbExecute(conn, "LOAD motherduck")
    
    auth_query <- paste0("SET motherduck_token='", token, "';")
    DBI::dbExecute(conn, auth_query)

    # Attach to MotherDuck 
    results <- tryCatch(
        {
            DBI::dbGetQuery(conn, "ATTACH 'md:'")
       },
        error = function(e) {
            cli::cli_alert_danger("Error: check your MotherDuck token")
            DBI::dbDisconnect(conn)
            conn <- NULL
         }
    )

   
    # return the connection object
    conn 
    
}


   
#    dbDisconnect(conn, shutdown = TRUE)
    