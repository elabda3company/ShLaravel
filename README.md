# Laravel Deployment Check Script

This shell script is designed to automate the process of checking and setting up a Laravel application after deployment. It ensures that the necessary directories, configurations, and services are properly set up and running.

## Features

- Checks the existence of essential storage folders and subfolders.
- Sets correct permissions for the storage and bootstrap/cache directories.
- Clears and caches Laravel configuration, routes, and views.
- Verifies the database connection by checking the migration status.
- Confirms the existence of the `.env` file and required environment variables.
- Ensures that the storage symlink is correctly created.
- Verifies the presence of the `.htaccess` file in the `public` directory.
- Installs Composer dependencies.
- Checks for pending database migrations.
- Generates a new application key.
- Dispatches a test job to verify that the queue worker is functioning correctly.
- Provides a final summary of all checks.

## Usage

### Prerequisites

Ensure that the following prerequisites are met before running the script:

- The script should be executed in the root directory of your Laravel project.
- The Laravel application must have a configured queue connection (e.g., `database`, `redis`). The `sync` driver is not supported for the queue check.

### Running the Script

1. Download or copy the script into the root directory of your Laravel project.
2. Make the script executable:
    ```bash
    chmod +x your-script-name.sh
    ```
3. Run the script:
    ```bash
    ./your-script-name.sh
    ```

### Script Breakdown

1. **Checking Storage Folders**:
    - The script checks for the existence of the `storage` directory and its subfolders (`app`, `framework`, `logs`).
    - If any are missing, the script reports their absence.

2. **Setting Permissions**:
    - Correct permissions are set for the `storage` and `bootstrap/cache` directories to ensure they are writable.

3. **Cleaning and Caching**:
    - All Laravel caches (config, routes, views) are cleared and then re-cached to ensure the latest configurations are applied.

4. **Database Connection Check**:
    - The script checks the migration status to confirm a successful connection to the database.

5. **Environment File and Variables**:
    - The script verifies the existence of the `.env` file and ensures that critical environment variables (`APP_KEY`, `DB_HOST`, `DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD`) are set.

6. **Storage Symlink**:
    - The script checks if the storage symlink is created for public file access. If missing, it attempts to create it.

7. **.htaccess Check**:
    - Ensures that the `.htaccess` file exists in the `public` directory, which is important for Apache web server configurations.

8. **Composer Dependencies**:
    - The script installs or updates Composer dependencies.

9. **Pending Migrations**:
    - Checks if there are any pending migrations that need to be manually run.

10. **Application Key**:
    - Generates a new application key for the Laravel application.

11. **Queue Worker Check**:
    - Dispatches a test job to the queue and checks if it is processed within 10 seconds. The result is logged and reported.

12. **Final Summary**:
    - Provides a summary of all checks with their respective statuses.

## Author

**George Awad**  
Digital Creativity Co  
[https://el-abda3.com](https://el-abda3.com)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
