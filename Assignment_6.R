conn <-- dbconnect (RSQlite::SQlite(), Camera_Trap_Database.db)

dbExecute (Camera_Trap_Database_db, "
  CREATE TABLE sites (
    site CHAR(2) NOT NULL PRIMARY KEY,
    lat REAL,
    long REAL,
    shore_inland VARCHAR CHECK(shore_inland IN ('Shore','Inland'))
  );
")


sites <- read.csv("Camera_Trap_Database.csv",
                  stringsAsFactors = FALSE)

dbExecute (Camera_Trap_Database_db, "
  CREATE TABLE camera_deployment (
    camera_id VARCHAR(5) NOT NULL PRIMARY KEY,
    start_deployment TEXT,
    end_deployment TEXT,
    site CHAR(2),
    FOREIGN KEY (site) REFERENCES sites(site)
  );
")

camera_deployment <- read.csv("Camera_Trap_Database.csv",
                              stringsAsFactors = FALSE)

dbExecute (Camera_Trap_Database_db, "
  CREATE TABLE picture_file (
    file_name VARCHAR(12) NOT NULL PRIMARY KEY,
    date TEXT,
    time TEXT,
    trigger_mode VARCHAR CHECK (trigger_mode IN ('M','T')),
    camera_id VARCHAR(5),
    FOREIGN KEY (camera_id) REFERENCES camera_deployment(camera_id)
  );
")

picture_file <- read.csv("Camera_Trap_Database.csv",
                         stringsAsFactors = FALSE)

dbExecute (Camera_Trap_Database_db, "
  CREATE TABLE detections (
    detection_id TEXT NOT NULL PRIMARY KEY,
    species TEXT,
    number INTEGER,  
    file_name VARCHAR(12),
    FOREIGN KEY (file_name) REFERENCES picture_file(file_name)
  );
")

detections <- read.csv("Camera_Trab_Database.csv",
                       stringsAsFactors = FALSE)