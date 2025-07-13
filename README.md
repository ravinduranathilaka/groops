# Groops

A modern Rails 8 task management application with hierarchical group organization, built with PostgreSQL, Tailwind CSS, and Hotwire.

## Overview

Groops is a collaborative task management system that allows organizations to:
- **Organize hierarchically**: Create nested groups with parent-child relationships
- **Manage tasks efficiently**: Create, assign, and track tasks with different urgency levels and statuses
- **Control visibility**: Tasks are visible to users based on their group hierarchy
- **User authentication**: Secure login system with password protection

## Features

### 🔐 Authentication System
- User registration and login with secure password hashing
- Session-based authentication
- Protected routes requiring login

### 🏢 Hierarchical Group Management
- Create nested organizational groups (parent-child relationships)
- Breadth-First Search algorithm for efficient group traversal
- Users belong to specific groups within the hierarchy

### 📋 Task Management
- **Task Creation**: Create tasks with name, description, and urgency levels
- **Assignment System**: Assign tasks to specific users or leave unassigned
- **Status Tracking**: Track task progress (unassigned → assigned → started → completed → cancelled)
- **Visibility Control**: Tasks are visible based on group hierarchy
- **Search Functionality**: Search tasks by name or description
- **Urgency Levels**: Urgent, High, Mid, Low priority levels

### 🎨 Modern UI
- Responsive design with Tailwind CSS
- Hotwire for dynamic interactions
- Clean, intuitive interface

## Prerequisites

- Ruby 3.2+ (check with `ruby --version`)
- PostgreSQL 9.3+ 
- Node.js (for asset compilation)
- Rails 8.0.2

## System Dependencies

### PostgreSQL Setup
1. Install PostgreSQL on your system
2. Create a PostgreSQL user (if not using default 'postgres' user)
3. Ensure PostgreSQL service is running

### Ruby Dependencies
- Bundler gem for managing Ruby dependencies

## Installation & Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Groops
   ```

2. **Install Ruby dependencies**
   ```bash
   bundle install
   ```

3. **Configure database**
   The application is configured to use PostgreSQL with the following settings:
   - Database: `groops_development` (development)
   - Database: `groops_test` (testing)
   - Username: `postgres`
   - Password: `1234` (configured in `config/database.yml`)

   **Note**: For production, use environment variables for database credentials.

4. **Create and setup database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

5. **Install JavaScript dependencies**
   ```bash
   bin/importmap:install
   ```

6. **Start the development server**
   ```bash
   bin/dev
   ```

   The application will be available at `http://localhost:3000`

## Database Schema

### Users
- `username`: Unique username for login
- `password_digest`: Hashed password (using bcrypt)
- `name`: Display name
- `group_id`: Belongs to a group

### Groups
- `name`: Group name
- `parent_id`: Optional parent group (self-referential)

### Tasks
- `name`: Task title
- `description`: Task details
- `created_by_id`: User who created the task
- `assigned_to_id`: User assigned to the task (optional)
- `visible_up_to_id`: Group up to which the task is visible
- `urgency`: Priority level (urgent, high, mid, low)
- `status`: Current status (unassigned, assigned, started, completed, cancelled)
- `assigned_on`: Timestamp when task was assigned
- `completed_on`: Timestamp when task was completed

## Configuration

### Database Configuration
Database settings are in `config/database.yml`. The application uses:
- **Development**: `groops_development`
- **Test**: `groops_test` 
- **Production**: `groops_production`

### Environment Variables
For production deployment, set these environment variables:
- `DATABASE_URL`: Full PostgreSQL connection string
- `RAILS_ENV`: Set to `production`
- `RAILS_MASTER_KEY`: Rails master key for credentials

## Development

### Running Tests
```bash
# Run all tests
rails test

# Run specific test file
rails test test/models/user_test.rb

# Run system tests
rails test:system
```

### Code Quality
```bash
# Run RuboCop for code style checking
bundle exec rubocop

# Run Brakeman for security analysis
bundle exec brakeman
```

### Database Operations
```bash
# Create database
rails db:create

# Run migrations
rails db:migrate

# Reset database
rails db:reset

# Seed database with sample data
rails db:seed
```

## Technology Stack

- **Framework**: Rails 8.0.2
- **Database**: PostgreSQL
- **Frontend**: Tailwind CSS, Stimulus, Turbo
- **Asset Pipeline**: Propshaft
- **JavaScript**: Import maps (ESM)
- **Authentication**: bcrypt for password hashing
- **Deployment**: Kamal (Docker-based)

## Project Structure

```
Groops/
├── app/                    # Application code
│   ├── controllers/       # Rails controllers
│   │   ├── application_controller.rb  # Base controller with auth
│   │   ├── sessions_controller.rb     # Login/logout handling
│   │   ├── tasks_controller.rb        # Task CRUD operations
│   │   ├── users_controller.rb        # User management
│   │   └── groups_controller.rb       # Group management
│   ├── models/           # ActiveRecord models
│   │   ├── user.rb       # User model with authentication
│   │   ├── group.rb      # Group model with hierarchy
│   │   └── task.rb       # Task model with status/urgency
│   ├── views/            # ERB templates
│   ├── javascript/       # JavaScript files
│   └── assets/          # CSS, images, etc.
├── config/               # Configuration files
├── db/                  # Database migrations and seeds
├── test/                # Test files
└── public/              # Static files
```

## Key Features Implementation

### Hierarchical Group System
The application uses a self-referential association for groups, allowing unlimited nesting levels. The `bfs_descendant_ids` method in the Group model efficiently traverses the hierarchy using Breadth-First Search.

### Task Visibility
Tasks are visible to users based on their group hierarchy. Users can see tasks that are visible up to their group or any descendant groups.

### Authentication Flow
1. Users must log in to access the application
2. Sessions are managed securely with user ID storage
3. All routes (except login) require authentication
4. Password hashing is handled by bcrypt

## Deployment

This application is configured for deployment using Kamal. See `config/deploy.yml` for deployment configuration.

```bash
# Deploy to production
kamal deploy

# Deploy with specific version
kamal deploy --version <version>
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please open an issue in the repository.
