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

    