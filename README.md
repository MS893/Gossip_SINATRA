# The Gossip Project - Sinatra Web App

This is a web application built with Ruby and the Sinatra framework. It's an evolution of a simple command-line tool, now providing a full web interface to create, view, and manage "gossips" and their comments.

## Features

*   **Web Interface**: A responsive, dark-themed UI built with Bootstrap.
*   **Full CRUD for Gossips**:
    *   **Create**: Add new gossips through a web form.
    *   **Read**: View all gossips on the homepage and see a detailed view for each one.
    *   **Update**: Edit existing gossips.
    *   **Delete**: Remove gossips from the database.
*   **Commenting System**: Users can post comments on each gossip.
*   **Email Notifications**: Automatically sends an email notification when a new comment is posted.
*   **Flash Messages**: Provides user feedback for actions like creating or deleting items.
*   **Persistent Storage**: Uses simple CSV files (`gossip.csv`, `comments.csv`) as a database.

## Tech Stack

*   **Backend**: Ruby, Sinatra
*   **Frontend**: ERB (Embedded Ruby), Bootstrap 5
*   **Database**: CSV files
*   **Emailing**: Pony gem
*   **Environment Variables**: Dotenv gem

## Prerequisites

*   Ruby (version 2.7+ recommended)
*   Bundler

## Getting Started

1.  **Clone the repository**:
    ```bash
    git clone <your-repository-url>
    cd <project-directory>
    ```

2.  **Install dependencies**:
    ```bash
    bundle install
    ```

3.  **Set up environment variables**:
    Create a file named `.env` in the root of the project and add your email credentials. This is required for the email notification feature.
    ```
    # .env
    FREE_EMAIL_USER=your_email@free.fr
    FREE_EMAIL_PASSWD=your_password
    ```

4.  **Run the web server**:
    Use `rackup` to start the Sinatra application.
    ```bash
    rackup -p 4567
    ```
    Now, open your web browser and go to `http://localhost:4567`.

## Project Structure

*   `config.ru`: Rack configuration file to run the Sinatra application.
*   `lib/`: Contains the core logic.
    *   `controller.rb`: The main Sinatra application file, handling routes and web requests.
    *   `gossip.rb`: The **Gossip Model**. Handles all interactions with `gossip.csv`.
    *   `comment.rb`: The **Comment Model**. Handles all interactions with `comments.csv`.
*   `lib/views/`: Contains all the ERB templates for the web pages.
    *   `layout.erb`: The main layout file, providing the common HTML structure.
*   `db/`: Contains the CSV files used as a database.
