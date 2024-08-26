# 🚀 Laravel Deployment Check Script

This shell script automates the setup and checks necessary after deploying a Laravel application. It ensures all critical components, such as directories, permissions, and services, are correctly configured for smooth operation. 🛠️

## 🌟 Features

- ✅ **Checks**: Validates the existence of essential storage folders and subfolders.
- 🔐 **Sets Permissions**: Ensures correct permissions on storage and bootstrap/cache directories.
- 🧹 **Caches Management**: Clears and re-caches configurations, routes, and views.
- 🔗 **Database Verification**: Confirms the database connection by checking migration status.
- 📂 **Environment Setup**: Confirms `.env` file and necessary variables are correctly set.
- 🔄 **Storage Symlink**: Ensures symlink creation for the storage directory.
- 🔍 **File Verification**: Checks for `.htaccess` in the public directory.
- 📦 **Dependency Management**: Installs or updates Composer dependencies.
- ⏳ **Migration Check**: Looks for pending database migrations.
- 🔑 **Key Generation**: Creates a new application key.
- 🧪 **Queue Testing**: Dispatches a test job to ensure the queue is working.
- 📋 **Summary Report**: Provides a final summary of all checks performed.

## 📋 Usage

### ⚙️ Prerequisites

- Ensure the script is executed at the **root directory** of your Laravel project.
- Your Laravel setup should have a **configured queue connection**.

### ▶️ Running the Script

#### Method 1: Manual

1. **Download/Copy** the script into your project's root directory.
2. **Make executable**:
   ```
   chmod +x run.sh
   ```
3. **Execute**:
   ```
   ./run.sh
   ```

#### Method 2: Direct Execution

Directly download and execute the script with:
```
wget -O - https://raw.githubusercontent.com/elabda3company/ShLaravel/main/run.sh | bash
```

## 🔍 Script Breakdown

1. **Storage Check**: Ensures `storage` and subdirectories exist.
2. **Permissions**: Sets correct permissions on necessary directories.
3. **Caching**: Clears and re-caches settings for optimal performance.
4. **Database Connection**: Verifies connection through migration status.
5. **Environment Checks**: Validates `.env` setup.
6. **Symlink Creation**: Verifies or creates storage symlink.
7. **File Presence**: Confirms `.htaccess` existence for Apache configurations.
8. **Dependencies**: Manages Composer dependencies.
9. **Migrations**: Checks for and alerts on pending migrations.
10. **Key Generation**: Generates a new application key.
11. **Queue Test**: Tests queue functionality with a job dispatch.
12. **Summary**: Provides a comprehensive check summary.

## 👤 Author

**George Awad**  
Digital Creativity Co  
[https://el-abda3.com](https://el-abda3.com)

## 📜 License

Licensed under the MIT License. See the LICENSE file for more details.

---

This format should improve clarity and usability, with emoji usage to make the sections easily distinguishable.
