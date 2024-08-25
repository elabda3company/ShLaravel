#!/bin/bash

echo ""
echo "===================================="
echo "Script executed by:"
echo "George Awad"
echo "Digital Creativity Co"
echo "https://el-abda3.com"
echo "Mobile Applications Leaders [Let's work together]"
echo "===================================="

sleep 5

# Function to print a header for sections
function print_header {
    echo "====================="
    echo "$1"
    echo "====================="
}

# Define the URL of the run.sh file in the GitHub repository
wget -O - https://raw.githubusercontent.com/elabda3company/ShLaravel/main/job.sh | bash

echo "Script downloaded, executed "

# Get the current user
CURRENT_USER=$(whoami)

# Initialize variables for the summary
STORAGE_STATUS="OK"
ENV_FILE_STATUS="OK"
ENV_VARS_STATUS="OK"
SYMLINK_STATUS="OK"
HTACCESS_STATUS="OK"
COMPOSER_STATUS="OK"
MIGRATIONS_STATUS="Checked"
APP_KEY_STATUS="Regenerated"
QUEUE_STATUS="Checked (via test job)"
DB_CONNECTION_STATUS="Unknown"

# Check if the storage folder and its subfolders exist
print_header "Checking storage folder and subfolders"

if [ -d "storage" ]; then
    echo "Storage folder exists."
else
    STORAGE_STATUS="Missing"
    echo "Storage folder does not exist. Please create it."
fi

# Check for subfolders
subfolders=("app" "framework" "logs")

for subfolder in "${subfolders[@]}"; do
    if [ -d "storage/$subfolder" ]; then
        echo "Subfolder storage/$subfolder exists."
    else
        STORAGE_STATUS="Missing subfolder"
        echo "Subfolder storage/$subfolder does not exist. Please create it."
    fi
done


# Fix permissions for the entire Laravel directory and its subfolders
print_header "Setting correct permissions for the entire Laravel directory"

# Set the correct owner for the entire Laravel directory
chown -R $CURRENT_USER:$CURRENT_USER .

# Set the correct permissions for directories
find . -type d -exec chmod 775 {} \;

# Set the correct permissions for files
find . -type f -exec chmod 664 {} \;

echo "Permissions for the entire Laravel directory and its subfolders have been set."

# Fix permissions for storage and bootstrap/cache directories
print_header "Setting correct permissions"

chown -R $CURRENT_USER:$CURRENT_USER storage bootstrap/cache
chmod -R 775 storage bootstrap/cache

echo "Permissions set."

# Clean all Laravel caches
print_header "Cleaning Laravel caches"
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan config:cache

if [ $? -ne 0 ]; then
    echo "Failed to clear cache. Make sure you have the appropriate permissions."
else
    echo "All caches cleared and configurations cached."
fi

# Check database connection
print_header "Checking database connection"

# Attempt to get the migration status
DB_STATUS=$(php artisan migrate:status --no-interaction 2>&1)

# Check if the output contains "Migration table not found" (indicating a failed connection)
if [[ "$DB_STATUS" == *"Migration table not found"* ]]; then
    DB_CONNECTION_STATUS="Failed"
    echo "Database connection failed. Details: $DB_STATUS"
elif [[ "$DB_STATUS" == *"Yes"* || "$DB_STATUS" == *"No migrations found"* ]]; then
    DB_CONNECTION_STATUS="Successful"
    echo "Database connection successful."
else
    DB_CONNECTION_STATUS="Failed (Unexpected output)"
    echo "Database connection failed. Unexpected output: $DB_STATUS"
fi

# Additional Checks

# Check if .env file exists
print_header "Checking .env file"

if [ -f ".env" ]; then
    echo ".env file exists."
else
    ENV_FILE_STATUS="Missing"
    echo ".env file is missing. Please create it."
fi

# Check if required environment variables are set
print_header "Checking required environment variables"

REQUIRED_ENV_VARS=("APP_KEY" "DB_HOST" "DB_DATABASE" "DB_USERNAME" "DB_PASSWORD")

for var in "${REQUIRED_ENV_VARS[@]}"; do
    if grep -q "^$var=" .env; then
        echo "$var is set."
    else
        ENV_VARS_STATUS="Missing"
        echo "$var is not set. Please configure it in your .env file."
    fi
done

# Check if storage symlink exists (for Laravel apps that use 'php artisan storage:link')
print_header "Checking storage symlink"

if [ -L "public/storage" ]; then
    echo "Storage symlink exists."
else
    SYMLINK_STATUS="Missing"
    echo "Storage symlink does not exist. Creating symlink..."
    php artisan storage:link
    if [ $? -eq 0 ]; then
        echo "Storage symlink created successfully."
    else
        SYMLINK_STATUS="Failed"
        echo "Failed to create storage symlink."
    fi
fi

# Check if the public/.htaccess file exists
print_header "Checking .htaccess file"

if [ -f "public/.htaccess" ]; then
    echo ".htaccess file exists."
else
    HTACCESS_STATUS="Missing"
    echo ".htaccess file is missing. Please ensure your server configuration is correct."
fi

# Check Composer dependencies
print_header "Checking Composer dependencies"
composer install --no-interaction --prefer-dist --optimize-autoloader

if [ $? -eq 0 ]; then
    echo "Composer dependencies installed successfully."
else
    COMPOSER_STATUS="Failed"
    echo "Failed to install Composer dependencies. Please check for errors."
fi

# Check for pending migrations without running them
print_header "Checking for pending migrations"

php artisan migrate:status | grep "No" > /dev/null
if [ $? -eq 0 ]; then
    MIGRATIONS_STATUS="Pending migrations detected"
    echo "Pending migrations detected. Please run migrations manually if needed."
else
    echo "No pending migrations."
fi

# Always generate a new application key
print_header "Generating new application key"

php artisan key:generate
if [ $? -eq 0 ]; then
    echo "New application key generated and set successfully."
else
    APP_KEY_STATUS="Failed"
    echo "Failed to generate the application key. Please check for errors."
fi

# Georgeeeeeee eee eee eee eee eee eee eee eee eee eee eee 

# Function to print a header for sections
function print_header {
    echo "====================="
    echo "$1"
    echo "====================="
}

print_header "Checking if queue worker is running by dispatching a test job"

# Ensure the queue connection is set to an asynchronous driver
QUEUE_CONNECTION=$(grep QUEUE_CONNECTION .env | cut -d '=' -f2)
if [ "$QUEUE_CONNECTION" == "sync" ]; then
    echo "QUEUE_CONNECTION is set to 'sync', which runs jobs synchronously. Change it to 'database', 'redis', or another asynchronous driver."
    exit 1
fi

# Clear the log file to start fresh
> storage/logs/job_processed.log

# Step 1: Dispatch the TestQueueJob
print_header "Dispatching TestQueueJob"
php artisan tinker --execute="App\Jobs\TestQueueJob::dispatch();"
echo "Job dispatched."

# Step 2: Wait for 10 seconds to allow the job to be processed
sleep 10

# Step 3: Check the log file for the processed job message
print_header "Checking if the job was processed"
if grep -q "Job processed with ID:" storage/logs/job_processed.log; then
    echo "Queue worker processed the job successfully."
else
    echo "Queue worker did NOT process the job."
fi

# Georgeeeeeee eee eee eee eee eee eee eee eee eee eee eee 

# Final summary
print_header "Summary of checks"

echo "1. Storage folder and subfolders:        $STORAGE_STATUS"
echo "2. .env file:                            $ENV_FILE_STATUS"
echo "3. Required environment variables:       $ENV_VARS_STATUS"
echo "4. Storage symlink:                      $SYMLINK_STATUS"
echo "5. .htaccess file:                       $HTACCESS_STATUS"
echo "6. Composer dependencies:                $COMPOSER_STATUS"
echo "7. Pending migrations:                   $MIGRATIONS_STATUS"
echo "8. Application key:                      $APP_KEY_STATUS"
echo "9. Queue worker:                         $QUEUE_STATUS"
echo "10. Database connection:                 $DB_CONNECTION_STATUS"

echo ""
if [ "$DB_CONNECTION_STATUS" = "Successful" ] && [ "$QUEUE_STATUS" = "Checked (via test job)" ]; then
    echo "Deployment checks completed successfully."
else
    echo "Some checks failed. Please review the details above."
fi
