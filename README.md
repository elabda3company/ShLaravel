# Laravel TestQueueJob

A simple Laravel job that logs its processing to a file. This job can be used to test if your Laravel queue worker is processing jobs correctly.

## Installation

1. Clone the repository or download the `TestQueueJob.php` file.
2. Place the `TestQueueJob.php` file in your Laravel project's `app/Jobs` directory.

## Usage

1. Make sure your Laravel project is set up with a queue connection (e.g., database, redis).
2. Run the queue worker:
    ```bash
    php artisan queue:work
    ```
3. Dispatch the job from your application, or use Tinker:
    ```bash
    php artisan tinker --execute="App\Jobs\TestQueueJob::dispatch();"
    ```
4. Check the `storage/logs/job_processed.log` file to see if the job was processed.

## Author

**George Awad**  
Digital Creativity Co  
[https://el-abda3.com](https://el-abda3.com)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

