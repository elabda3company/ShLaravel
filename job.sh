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


# Define the path where the job class should be created
JOB_FILE_PATH="app/Jobs/TestQueueJob.php"

# Create the directory if it doesn't exist
mkdir -p "$(dirname "$JOB_FILE_PATH")"

# Create the job class file
cat <<EOL > $JOB_FILE_PATH
<?php
/**
 * TestQueueJob.php
 * Laravel job that logs its processing to a file.
 *
 * @package     Digital Creativity Co
 * @author      George Awad <apps@@el-abda3.com>
 * @copyright   Copyright (c) 2024 Digital Creativity Co
 * @license     MIT
 * @link        https://el-abda3.com
 * Mobile Applications Leaders [Let's work together]
 */

namespace App\Jobs;


use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\File;

class TestQueueJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public \$jobId;

    public function __construct()
    {
        // Generate a unique ID for this job
        \$this->jobId = uniqid('test:', true);
    }

    public function handle()
    {
        // Log when the job is processed
        Log::info("TestQueueJob processed with ID: {\$this->jobId}");

        // Write to a custom file to confirm the job was processed
        File::append(storage_path('logs/job_processed.log'), "Job processed with ID: {\$this->jobId}\n");

        // You could also directly echo to terminal if running synchronously
        echo "Job processed with ID: {\$this->jobId}\n";
    }
}
EOL

# Confirm the file creation
echo "Job class created at $JOB_FILE_PATH"
