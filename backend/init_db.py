# TODO Schau dir die Dockerfile an. Nimm die Kommandozeilenparameter und passe damit appsettings.json an
# In appsettings.json findest du unter "Database" einen string. In den tust du die neuen Parameter

import sys

def rename_file(host, port, db, user, psswrt):
    with open('appsettings.json', 'r+') as f:
        text = f.read()
        f.seek(0)
        print(text)
        try:
            (before_text,focus_text) = text.split("\"Database\": \"")
            (focus_text,after_text) = focus_text.split("\"")
        except:
            print("String decoding failed")
            return 1
            
        focus_text = f"Server={host}; Database={db}; Password={psswrt}; User={user}; Port={user}"
        
        file_text = before_text + "\"Database\": \"" + focus_text + "\"" + after_text
        print(file_text)
        f.truncate(0)
        f.write(file_text)
        return 0
       
         
 
if __name__ == "__main__":
    print(sys.argv[:1])
    rename_file(*sys.argv[1:])
    
"""{
   "Logging": {
     "LogLevel": {
       "Default": "Information",
       "Microsoft.AspNetCore": "Warning"
     }
   },
   "AllowedHosts": "*",
   "Jwt": {
     "Issuer": "ClockIn Ltd.",
     "Audience": "clock.in",
     "Key": "db3OIsj+BXE9NZDy0t8W3TcNekrF+2d/1sFnWG4HnV8TZY30iTOdtVWJG8abWvB1GlOgJuQZdcF2Luqm/hccMw=="
   },
   "ConnectionStrings": {
     "Database": "Server=database; Database=clock_in; Password=123456; User=dbuser; Port=3306"
   }
 }
"""
    