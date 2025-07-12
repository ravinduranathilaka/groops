# Groops

A modern Rails 8 application built with PostgreSQL, Tailwind CSS, and Hotwire.

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
- **Deployment**: Kamal (Docker-based)

## Project Structure

```
Groops/
├── app/                    # Application code
│   ├── controllers/       # Rails controllers
│   ├── models/           # ActiveRecord models
│   ├── views/            # ERB templates
│   ├── javascript/       # JavaScript files
│   └── assets/          # CSS, images, etc.
├── config/               # Configuration files
├── db/                  # Database migrations and seeds
├── test/                # Test files
└── public/              # Static files
```

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
