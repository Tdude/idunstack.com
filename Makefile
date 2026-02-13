# rebelkayaks.eu - Idun Stack
# Root-level Makefile for local + server management

# Load environment variables (contract)
# 1) .env             (committed, sets SITE_NAME + safe defaults)
# 2) .env.$(SITE_NAME) (gitignored, site secrets + production values)
# 3) .env.local        (gitignored, per-machine local overrides)
-include .env
-include .env.$(SITE_NAME)
-include .env.local
export

DC := docker compose --project-name $(COMPOSE_PROJECT_NAME) --project-directory $(CURDIR)

# Calculate ports based on PORT_OFFSET (for display/documentation)
DB_PORT := $(shell echo $$((5433 + $(PORT_OFFSET))))
IDUN_API_PORT := $(shell echo $$((8011 + $(PORT_OFFSET))))
BIFROST_API_PORT := $(shell echo $$((8012 + $(PORT_OFFSET))))
SKJOLD_API_PORT := $(shell echo $$((8013 + $(PORT_OFFSET))))
MIMER_API_PORT := $(shell echo $$((8014 + $(PORT_OFFSET))))
HEDEBY_API_PORT := $(shell echo $$((8015 + $(PORT_OFFSET))))
HUGIN_API_PORT := $(shell echo $$((8016 + $(PORT_OFFSET))))
SKIIN_API_PORT := $(shell echo $$((8017 + $(PORT_OFFSET))))
UI_PORT := $(shell echo $$((5176 + $(PORT_OFFSET))))

# Optional services
ENABLE_HUGIN ?= true

# Set BUILD=false to skip image builds (useful when Docker Hub is unreachable)
BUILD ?= true

.PHONY: help up down stop-services restart ps logs health build clean shell migrate migrations migrate-all db-ready


.PHONY: dev dev-ui

dev: ## Start full local dev stack (build + up + migrations)
	@echo "Starting full local dev stack..."
	@echo "E-learning setting: ENABLE_ELEARNING=$(ENABLE_ELEARNING)"
	@echo "Shop setting: ENABLE_SHOP=$(ENABLE_SHOP)"
	@buildflag="--build"; \
	if [ "$(BUILD)" = "false" ]; then buildflag=""; fi; \
	services="db idun-api bifrost-api skjold-api idun-ui"; \
	if [ "$(ENABLE_HUGIN)" = "true" ]; then services="$$services hugin-api"; fi; \
	if [ "$(ENABLE_ELEARNING)" = "true" ]; then services="$$services mimer-api"; fi; \
	if [ "$(ENABLE_SHOP)" = "true" ]; then services="$$services hedeby-api"; fi; \
	if [ "$(PUBLIC_ENABLE_SKIIN)" = "true" ] && [ -d "idun-stack/fastapi/services/skiin" ]; then services="$$services skiin-api"; fi; \
	echo "Starting services: $$services"; \
	$(DC) up $$buildflag -d $$services
	@$(MAKE) ps
	@echo ""
	@echo "Running database migrations..."
	@sleep 2
	@$(MAKE) migrations
	@echo ""
	@$(MAKE) health
	@echo ""
	@echo "Open site: http://localhost:$(UI_PORT)"
	@echo "(Tip: use 'make dev-ui' if you prefer running Vite natively.)"

dev-ui: ## Start backend-only for native Vite dev (no Docker UI)
	@echo "Starting backend-only (no Docker UI) for native Vite dev..."
	@echo "E-learning setting: ENABLE_ELEARNING=$(ENABLE_ELEARNING)"
	@echo "Shop setting: ENABLE_SHOP=$(ENABLE_SHOP)"
	@buildflag="--build"; \
	if [ "$(BUILD)" = "false" ]; then buildflag=""; fi; \
	services="db idun-api bifrost-api skjold-api"; \
	if [ "$(ENABLE_HUGIN)" = "true" ]; then services="$$services hugin-api"; fi; \
	if [ "$(ENABLE_ELEARNING)" = "true" ]; then services="$$services mimer-api"; fi; \
	if [ "$(ENABLE_SHOP)" = "true" ]; then services="$$services hedeby-api"; fi; \
	if [ "$(PUBLIC_ENABLE_SKIIN)" = "true" ] && [ -d "idun-stack/fastapi/services/skiin" ]; then services="$$services skiin-api"; fi; \
	echo "Starting services: $$services"; \
	$(DC) up $$buildflag -d $$services
	@$(MAKE) ps
	@echo ""
	@echo "Running database migrations..."
	@sleep 2
	@$(MAKE) migrations
	@echo ""
	@echo "Starting frontend dev server (Vite) from site root..."
	@echo "Open: http://localhost:$(UI_PORT)"
	@if [ ! -d "idun-stack/idun-ui/node_modules" ]; then \
		echo "Installing idun-ui npm dependencies (first run)..."; \
		pnpm --dir idun-stack/idun-ui install; \
	fi
	@API_URL="http://localhost:$(IDUN_API_PORT)/api/v1" \
	IDUN_API_URL="http://localhost:$(IDUN_API_PORT)" \
	BIFROST_API_URL="http://localhost:$(BIFROST_API_PORT)" \
	SKJOLD_API_URL="http://localhost:$(SKJOLD_API_PORT)" \
	SKJOLD_BASE_URL="http://localhost:$(SKJOLD_API_PORT)" \
	MIMER_API_URL="http://localhost:$(MIMER_API_PORT)" \
	HEDEBY_API_URL="http://localhost:$(HEDEBY_API_PORT)" \
	HUGIN_API_URL="http://localhost:$(HUGIN_API_PORT)" \
	SKIIN_API_URL="http://localhost:$(SKIIN_API_PORT)" \
	pnpm --dir idun-stack/idun-ui run dev -- --port $(UI_PORT)

help: ## Show help
	@echo "rebelkayaks.eu - Idun Stack"
	@echo ""
	@echo "Sane targets:"
	@echo "  dev           Start full local dev stack (build + up + migrations)"
	@echo "  dev-ui        Start backend-only for native Vite dev (UI runs separately)"
	@echo "  up            Start DB + APIs + UI (Docker)"
	@echo "  down          Stop containers"
	@echo "  restart       Restart containers"
	@echo "  ps            Show running services"
	@echo "  logs          Tail logs (SERVICE=name optional)"
	@echo "  health        Show local URLs + hints"
	@echo "  shell         Open shell in a service (SERVICE=...)"
	@echo "  migrations    Run migrations for enabled services (canonical)"
	@echo "  migrate-all   Alias for migrations"
	@echo "  remod         Update code/submodule and restart (does NOT auto-run migrations)"
	@echo "  cleanup       Non-destructive Docker cleanup (keeps DB volumes)"
	@echo ""
	@echo "Notes:"
	@echo "  - Advanced targets still exist; run 'make <target>' if you know it."
	@echo "  - Production migrations are explicit: make migrate-prod / make migrate-comments-prod"

# Core lifecycle
up: ## Start DB + APIs + UI (detached)
	@echo "E-learning setting: ENABLE_ELEARNING=$(ENABLE_ELEARNING)"
	@echo "Shop setting: ENABLE_SHOP=$(ENABLE_SHOP)"
	@buildflag="--build"; \
	if [ "$(BUILD)" = "false" ]; then buildflag=""; fi; \
	services="db idun-api bifrost-api skjold-api idun-ui"; \
	if [ "$(ENABLE_HUGIN)" = "true" ]; then services="$$services hugin-api"; fi; \
	if [ "$(ENABLE_ELEARNING)" = "true" ]; then services="$$services mimer-api"; fi; \
	if [ "$(ENABLE_SHOP)" = "true" ]; then services="$$services hedeby-api"; fi; \
	if [ "$(PUBLIC_ENABLE_SKIIN)" = "true" ] && [ -d "idun-stack/fastapi/services/skiin" ]; then services="$$services skiin-api"; fi; \
	echo "Starting services: $$services"; \
	$(DC) up $$buildflag -d $$services
	@$(MAKE) ps
	@echo ""
	@echo "Running database migrations..."
	@sleep 2
	@$(MAKE) migrations

# Start only Idun UI
idun: ## Start only Idun UI (detached)
	@$(DC) up --build -d idun-ui
	@$(MAKE) ps

down: ## Stop all containers (this project)
	@$(DC) down


stop-services: ## Stop app containers but keep db running (safe for blue-green cleanup)
	@echo "Stopping app services (keeping db running)..."
	@$(DC) stop idun-api bifrost-api skjold-api idun-ui || true
	@if [ "$(ENABLE_HUGIN)" = "true" ]; then $(DC) stop hugin-api || true; fi
	@if [ "$(ENABLE_ELEARNING)" = "true" ]; then $(DC) stop mimer-api || true; fi
	@if [ "$(ENABLE_SHOP)" = "true" ]; then $(DC) stop hedeby-api || true; fi
	@if [ "$(PUBLIC_ENABLE_SKIIN)" = "true" ]; then $(DC) stop skiin-api || true; fi
	@echo "Done. DB is still running."
	@$(MAKE) ps
restart: ## Restart all containers
	@$(DC) restart

ps: ## Show Compose services
	@$(DC) ps

logs: ## Tail logs (SERVICE=name to filter, e.g. SERVICE=idun-api)
	@if [ -n "$(SERVICE)" ]; then \
		echo "Logs for $(SERVICE)"; \
		$(DC) logs -f $(SERVICE); \
	else \
		echo "All service logs"; \
		$(DC) logs -f; \
	fi

health: ## Quick endpoints + health hints
	@echo "Containers:" && $(DC) ps
	@echo ""
	@echo "Local URLs (PORT_OFFSET=$(PORT_OFFSET)):"
	@echo "  Idun UI:    http://localhost:$(UI_PORT)"
	@echo "  Idun API:   http://localhost:$(IDUN_API_PORT)/api/v1 (or /docs)"
	@echo "  Bifrost:    http://localhost:$(BIFROST_API_PORT)/docs"
	@echo "  Skjold:     http://localhost:$(SKJOLD_API_PORT)/docs"
	@echo "  Mimer API:  http://localhost:$(MIMER_API_PORT)/docs (E-Learning)"
	@echo "  Hedeby API: http://localhost:$(HEDEBY_API_PORT)/docs (Shop)"
	@echo "  Hugin API:  http://localhost:$(HUGIN_API_PORT)/docs (AI Assistant)"
	@echo "  Skiin API:  http://localhost:$(SKIIN_API_PORT)/docs (Kayak Designer)"
	@echo "  Database:   localhost:$(DB_PORT)"
	@echo ""
	@echo "If APIs fail to connect to db, ensure db is healthy and services bind 0.0.0.0 internally."

build: ## Build images without starting (uses site env vars)
	@echo "Building with PORT_OFFSET=$(PORT_OFFSET), DISABLE_CSRF_CHECK=$(DISABLE_CSRF_CHECK)"
	@$(DC) build

build-clean: ## Rebuild images from scratch (no cache)
	@echo "Clean build with PORT_OFFSET=$(PORT_OFFSET), DISABLE_CSRF_CHECK=$(DISABLE_CSRF_CHECK)"
	@$(DC) build --no-cache

build-destroy: ## DESTROY! DESTROY! DESTROY! CAUTION: destructive and removes database content.
	@docker system prune -af
	@docker volume prune -f || true

prune-orphans: ## Remove orphan containers (safe cleanup)
	@echo "Removing orphan containers..."
	@$(DC) down --remove-orphans
	@echo "✓ Orphan containers removed"

clean-safe: ## Safe weekly cleanup (removes unused images/containers, keeps database volumes)
	@echo "=== Docker Safe Cleanup ==="
	@echo "Starting cleanup (database volumes will be preserved)..."
	@echo ""
	@echo "1/3 Removing stopped containers..."
	@docker container prune -f
	@echo ""
	@echo "2/3 Removing unused images..."
	@docker image prune -a -f
	@echo ""
	@echo "3/3 Removing build cache..."
	@docker builder prune -f
	@echo ""
	@echo "✓ Cleanup complete!"
	@echo "Disk usage after cleanup:"
	@docker system df

## ==========================
## Production-safe shortcuts
## ==========================
remod:
	@./scripts/setup-service-envs.sh 2>/dev/null || true
	@echo "Updating production stack..."
	@echo "Pulling latest code from git..."
	@git pull
	@echo "Updating submodule..."
	@git submodule update --init --recursive
	@echo "Pull complete, restarting services..."
	@make prod-down
	@make prod
	@echo ""
	@echo "Next: run migrations if needed:"
	@echo "  make migrate-prod"
	@echo "  make migrate-comments-prod"

cleanup: ## Non-destructive Docker cleanup (keeps database volumes)
	@echo "=== Docker Cleanup (non-destructive) ==="
	@echo "This removes unused containers/images/build cache, but keeps named volumes (DB)."
	@echo ""
	@echo "1/3 Removing stopped containers..."
	@docker container prune -f
	@echo ""
	@echo "2/3 Removing unused images..."
	@docker image prune -a -f
	@echo ""
	@echo "3/3 Removing build cache..."
	@docker builder prune -f
	@echo ""
	@echo "Disk usage after cleanup:"
	@docker system df

prod: ## Start production stack (no dev override)
	@echo "Ensuring .env.local is empty (production mode)..."
	@echo "" > idun-stack/idun-ui/.env.local
	@echo "Building and starting production stack..."
	@$(DC) -f docker-compose.yml up --build -d db
	@echo "Waiting for database to be ready..."
	@$(DC) -f docker-compose.yml exec -T db sh -c 'until pg_isready -U "$$POSTGRES_USER" -d "$$POSTGRES_DB"; do echo "Postgres is unavailable - sleeping"; sleep 2; done; echo "Postgres is up"'
	@echo "Starting all services..."
	@echo "E-learning setting: ENABLE_ELEARNING=$(ENABLE_ELEARNING)"
	@echo "Shop setting: ENABLE_SHOP=$(ENABLE_SHOP)"
	@services="idun-api bifrost-api skjold-api hugin-api idun-ui"; \
	if [ "$(ENABLE_ELEARNING)" = "true" ]; then services="$$services mimer-api"; fi; \
	if [ "$(ENABLE_SHOP)" = "true" ]; then services="$$services hedeby-api"; fi; \
	if [ "$(PUBLIC_ENABLE_SKIIN)" = "true" ] && [ -d "idun-stack/fastapi/services/skiin" ]; then services="$$services skiin-api"; fi; \
	echo "Starting services: $$services"; \
	$(DC) -f docker-compose.yml up --build -d $$services; \
	if [ "$(ENABLE_ELEARNING)" = "true" ]; then \
		echo ""; \
		echo "Running Mimer migrations..."; \
		$(DC) -f docker-compose.yml exec -T mimer-api alembic upgrade head || echo "Migrations already up to date or container not ready"; \
	fi
	@$(DC) -f docker-compose.yml ps
	@echo ""
	@echo "Verifying PUBLIC_API_URL..."
	@$(DC) -f docker-compose.yml exec idun-ui printenv PUBLIC_API_URL || echo "Container not ready yet"

prod-down: ## Stop production stack
	@$(DC) -f docker-compose.yml down

prod-restart: ## Restart production stack
	@$(DC) -f docker-compose.yml restart

prod-ps: ## Show production stack status
	@$(DC) -f docker-compose.yml ps

prod-logs: ## Tail production logs (SERVICE=name to filter)
	@if [ -n "$(SERVICE)" ]; then \
		echo "[prod] Logs for $(SERVICE)"; \
		$(DC) -f docker-compose.yml logs -f $(SERVICE); \
	else \
		echo "[prod] All service logs"; \
		$(DC) -f docker-compose.yml logs -f; \
	fi

## ==========================
## Utils
## ==========================
shell: ## Open shell in a service: make shell SERVICE=idun-api
	@if [ -z "$(SERVICE)" ]; then \
		echo "Use: make shell SERVICE=idun-api"; exit 1; \
	fi
	@$(DC) exec $(SERVICE) /bin/sh

## ==========================
## Testing (UI app)
## ==========================
TEST_DIR ?= svelte/idun-ui

test-install: ## Install Playwright browsers/deps (run once)
	@cd $(TEST_DIR) && pnpm run test:install

test-unit: ## Run unit tests (Vitest)
	@cd $(TEST_DIR) && pnpm run test:unit

test-e2e: ## Run end-to-end tests (Playwright, mocked network) with fresh test server
	@cd $(TEST_DIR) && CI=1 pnpm run test:e2e

test-e2e-headed: ## Run e2e tests in headed mode

test-e2e-ui: ## Open Playwright UI test runner
	@cd $(TEST_DIR) && pnpm run test:e2e:ui

test-e2e-trace: ## Run e2e with trace collection for debugging
	@cd $(TEST_DIR) && CI=1 npx playwright test --trace on

test: ## Run unit + e2e tests
	@$(MAKE) test-unit
	@$(MAKE) test-e2e

db-ready: ## Show db logs for readiness
	@$(DC) logs --tail=200 db | egrep -i "ready to accept|database system is ready" || true

# Idun API migrations (CMS + Payments)
migrate: ## Run all Idun DB migrations (CMS + Payments)
	@echo "Running Idun API migrations..."
	@echo "1. Ensuring payment_orders table exists..."
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "\
		CREATE TABLE IF NOT EXISTS payment_orders ( \
			id UUID PRIMARY KEY DEFAULT gen_random_uuid(), \
			user_id UUID NOT NULL, \
			resource_type VARCHAR(50) NOT NULL, \
			resource_id VARCHAR(255) NOT NULL, \
			billing_mode VARCHAR(20) NOT NULL DEFAULT 'one_time', \
			currency VARCHAR(10) NOT NULL, \
			amount_minor INTEGER NOT NULL, \
			status VARCHAR(50) NOT NULL DEFAULT 'pending', \
			stripe_payment_intent_id VARCHAR(255), \
			stripe_subscription_id VARCHAR(255), \
			stripe_customer_id VARCHAR(255), \
			created_at TIMESTAMP DEFAULT NOW(), \
			updated_at TIMESTAMP DEFAULT NOW() \
		);" || echo "Payment orders table already exists"
	@echo "2. Creating indexes..."
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "CREATE INDEX IF NOT EXISTS idx_payment_orders_user_id ON payment_orders(user_id);" || true
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "CREATE INDEX IF NOT EXISTS idx_payment_orders_resource ON payment_orders(resource_type, resource_id);" || true
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "CREATE INDEX IF NOT EXISTS idx_payment_orders_stripe_pi ON payment_orders(stripe_payment_intent_id);" || true
	@echo "3. Running Idun CMS migrations (idempotent runner)..."
	@$(DC) exec -T idun-api python -m app.migrations.run_all
	@echo "✓ Idun API migrations complete"

migrate-comments: ## Run Idun threaded comments migrations (comments table + comments_enabled)
	@echo "Running Idun threaded comments migrations..."
	@echo "1. Creating comments table (if missing)..."
	@$(DC) exec -T idun-api python -m app.migrations.add_comments_table
	@echo "2. Ensuring pages.comments_enabled exists..."
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "ALTER TABLE pages ADD COLUMN IF NOT EXISTS comments_enabled BOOLEAN NOT NULL DEFAULT false;" || true
	@echo "✓ Comments migrations complete"

migrations: ## Run all migrations for enabled services (canonical)
	@$(MAKE) migrate
	@$(MAKE) migrate-comments
	@$(MAKE) skjold-migrate
	@if [ "$(ENABLE_ELEARNING)" = "true" ]; then \
		$(MAKE) mimer-migrate; \
	fi
	@if [ "$(ENABLE_SHOP)" = "true" ]; then \
		$(MAKE) hedeby-migrate; \
	fi

migrate-all: ## Run all migrations for enabled services
	@$(MAKE) migrations

migrate-all-prod: ## Run all migrations for enabled services in production
	@$(MAKE) migrate-prod
	@$(MAKE) migrate-comments-prod
	@$(MAKE) skjold-migrate
	@if [ "$(ENABLE_ELEARNING)" = "true" ]; then \
		$(MAKE) mimer-migrate; \
	fi
	@if [ "$(ENABLE_SHOP)" = "true" ]; then \
		$(MAKE) hedeby-migrate; \
	fi

migrations-dev: ## Run all Idun DB migrations in development
	@$(MAKE) migrations

migrate-prod: ## Run all Idun DB migrations in production
	@echo "Running Idun API migrations (production)..."
	@echo "1. Ensuring payment_orders table exists..."
	@$(DC) -f docker-compose.yml exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "\
		CREATE TABLE IF NOT EXISTS payment_orders ( \
			id UUID PRIMARY KEY DEFAULT gen_random_uuid(), \
			user_id UUID NOT NULL, \
			resource_type VARCHAR(50) NOT NULL, \
			resource_id VARCHAR(255) NOT NULL, \
			billing_mode VARCHAR(20) NOT NULL DEFAULT 'one_time', \
			currency VARCHAR(10) NOT NULL, \
			amount_minor INTEGER NOT NULL, \
			status VARCHAR(50) NOT NULL DEFAULT 'pending', \
			stripe_payment_intent_id VARCHAR(255), \
			stripe_subscription_id VARCHAR(255), \
			stripe_customer_id VARCHAR(255), \
			created_at TIMESTAMP DEFAULT NOW(), \
			updated_at TIMESTAMP DEFAULT NOW() \
		);" || echo "Payment orders table already exists"
	@echo "2. Creating indexes..."
	@$(DC) -f docker-compose.yml exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "CREATE INDEX IF NOT EXISTS idx_payment_orders_user_id ON payment_orders(user_id);" || true
	@$(DC) -f docker-compose.yml exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "CREATE INDEX IF NOT EXISTS idx_payment_orders_resource ON payment_orders(resource_type, resource_id);" || true
	@$(DC) -f docker-compose.yml exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "CREATE INDEX IF NOT EXISTS idx_payment_orders_stripe_pi ON payment_orders(stripe_payment_intent_id);" || true
	@echo "3. Running Idun CMS migrations (idempotent runner)..."
	@$(DC) -f docker-compose.yml exec -T idun-api python -m app.migrations.run_all
	@echo "✓ Idun API migrations complete (production)"

migrate-comments-prod: ## Run Idun threaded comments migrations in production
	@echo "Running Idun threaded comments migrations (production)..."
	@echo "1. Creating comments table (if missing)..."
	@$(DC) -f docker-compose.yml exec -T idun-api python -m app.migrations.add_comments_table
	@echo "2. Ensuring pages.comments_enabled exists..."
	@$(DC) -f docker-compose.yml exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "ALTER TABLE pages ADD COLUMN IF NOT EXISTS comments_enabled BOOLEAN NOT NULL DEFAULT false;" || true
	@echo "✓ Comments migrations complete (production)"

## ==========================
## Mimer E-Learning Platform
## ==========================
mimer-migrate: ## Run Mimer database migrations
	@echo "Running Mimer e-learning migrations..."
	@$(DC) exec mimer-api alembic upgrade head

mimer-migrate-down: ## Rollback Mimer migrations (one step)
	@echo "Rolling back Mimer migrations..."
	@$(DC) exec mimer-api alembic downgrade -1

mimer-migrate-reset: ## Reset Mimer database (WARNING: destructive)
	@echo "Resetting Mimer database (dropping all tables)..."
	@$(DC) exec mimer-api alembic downgrade base
	@echo "Re-running migrations..."
	@$(DC) exec mimer-api alembic upgrade head

mimer-logs: ## Tail Mimer API logs
	@$(MAKE) logs SERVICE=mimer-api

mimer-shell: ## Open shell in Mimer container
	@$(MAKE) shell SERVICE=mimer-api

mimer-restart: ## Restart Mimer API service
	@$(DC) restart mimer-api

mimer-rebuild: ## Rebuild and restart Mimer API
	@$(DC) build mimer-api
	@$(DC) up -d mimer-api
	@echo "Mimer API rebuilt and restarted"

mimer-status: ## Show Mimer service status and health
	@$(DC) ps mimer-api
	@echo ""
	@echo "API Documentation: http://127.0.0.1:$(MIMER_API_PORT)/docs"
	@echo "Frontend: http://127.0.0.1:$(UI_PORT)/learning"

mimer-tables: ## Show Mimer database tables
	@$(DC) exec db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "\dt" | grep -E "(courses|lessons|enrollments|progress|assessments|user_assessments)" || echo "No Mimer tables found"

## ==========================
## Skjold Authentication Service
## ==========================
skjold-migrate: ## Run Skjold database migrations (add role, username, bio, bio_image columns)
	@echo "Running Skjold Alembic migrations..."
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "ALTER TABLE users ADD COLUMN IF NOT EXISTS username VARCHAR(255);" || true
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "ALTER TABLE users ADD COLUMN IF NOT EXISTS bio TEXT;" || true
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "ALTER TABLE users ADD COLUMN IF NOT EXISTS bio_image VARCHAR(1024);" || true
	@echo "✓ Skjold migrations complete"

skjold-logs: ## Tail Skjold API logs
	@$(DC) logs -f skjold-api

## ==========================
## Hedeby Shop Platform
## ==========================
hedeby-migrate: ## Run Hedeby shop database migrations
	@echo "Running Hedeby shop migrations..."
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "ALTER TABLE shop_cart_items ADD COLUMN IF NOT EXISTS variant_id UUID;"
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "ALTER TABLE shop_cart_items ADD CONSTRAINT fk_cart_item_variant FOREIGN KEY (variant_id) REFERENCES shop_product_variants(id) ON DELETE CASCADE;" 2>/dev/null || true
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "CREATE INDEX IF NOT EXISTS idx_cart_items_variant_id ON shop_cart_items(variant_id);"
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "ALTER TABLE shop_cart_items DROP CONSTRAINT IF EXISTS unique_cart_product;" 2>/dev/null || true
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "ALTER TABLE shop_cart_items DROP CONSTRAINT IF EXISTS unique_cart_product_variant;" 2>/dev/null || true
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "ALTER TABLE shop_cart_items ADD CONSTRAINT unique_cart_product_variant UNIQUE (cart_id, product_id, variant_id);" 2>/dev/null || true
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "ALTER TABLE shop_order_items ADD COLUMN IF NOT EXISTS variant_id UUID;"
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "ALTER TABLE shop_order_items ADD CONSTRAINT fk_order_item_variant FOREIGN KEY (variant_id) REFERENCES shop_product_variants(id) ON DELETE SET NULL;" 2>/dev/null || true
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "CREATE INDEX IF NOT EXISTS idx_order_items_variant_id ON shop_order_items(variant_id);"
	@$(DC) exec -T db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "ALTER TABLE shop_order_items ADD COLUMN IF NOT EXISTS variant_name VARCHAR(255);"
	@echo "✓ Hedeby shop migrations complete"

hedeby-logs: ## Tail Hedeby API logs
	@$(MAKE) logs SERVICE=hedeby-api

hedeby-shell: ## Open shell in Hedeby container
	@$(MAKE) shell SERVICE=hedeby-api

hedeby-restart: ## Restart Hedeby API service
	@$(DC) restart hedeby-api

hedeby-rebuild: ## Rebuild and restart Hedeby API
	@$(DC) build hedeby-api
	@$(DC) up -d hedeby-api
	@echo "Hedeby API rebuilt and restarted"

hedeby-status: ## Show Hedeby service status and health
	@$(DC) ps hedeby-api
	@echo ""
	@echo "API Documentation: http://127.0.0.1:$(HEDEBY_API_PORT)/docs"
	@echo "Shop Frontend: http://127.0.0.1:$(UI_PORT)/shop"

hedeby-tables: ## Show Hedeby database tables
	@$(DC) exec db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "\dt" | grep -E "shop_" || echo "No Hedeby shop tables found"

## ==========================
## Skiin Kayak Designer
## ==========================
skiin-logs: ## Tail Skiin API logs
	@$(MAKE) logs SERVICE=skiin-api

skiin-shell: ## Open shell in Skiin container
	@$(MAKE) shell SERVICE=skiin-api

skiin-restart: ## Restart Skiin API service
	@$(DC) restart skiin-api

skiin-rebuild: ## Rebuild and restart Skiin API
	@$(DC) build skiin-api
	@$(DC) up -d skiin-api
	@echo "Skiin API rebuilt and restarted"

skiin-status: ## Show Skiin service status and health
	@$(DC) ps skiin-api
	@echo ""
	@echo "API Documentation: http://127.0.0.1:$(SKIIN_API_PORT)/docs"
	@echo "Designer Frontend: http://127.0.0.1:$(UI_PORT)/designer"

skiin-tables: ## Show Skiin database tables
	@$(DC) exec db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) -c "\dt" | grep -E "skiin_" || echo "No Skiin tables found"

skiin-seed: ## Seed Skiin templates from SVG files
	@$(DC) exec skiin-api python /app/seed_templates.py

## ==========================
## Hugin is X AI
## ==========================
hugin-logs: ## Tail Hugin API logs
	@$(MAKE) logs SERVICE=hugin-api

hugin-status: ## Show Hugin service status
	@$(DC) ps hugin-api
	@echo ""
	@echo "API Documentation: http://127.0.0.1:$(HUGIN_API_PORT)/docs"
	@echo "Health Check: http://127.0.0.1:$(HUGIN_API_PORT)/health"

hugin-restart: ## Restart Hugin API service
	@$(DC) restart hugin-api
