# Makefile for GitHub Pages Publishing
# Usage: make publish

.PHONY: publish setup clean status help

# Default target
help:
	@echo "GitHub Pages Publishing Commands:"
	@echo "  make publish  - Build and deploy to GitHub Pages"
	@echo "  make setup    - Configure GitHub Pages (run once)"
	@echo "  make status   - Check deployment status"
	@echo "  make clean    - Clean generated files"
	@echo "  make serve    - Preview locally (requires Python)"

# Main publish command
publish:
	@echo "📦 Publishing to GitHub Pages..."
	@git add -A
	@git commit -m "Update GitHub Pages content - $$(date '+%Y-%m-%d %H:%M')" || echo "No changes to commit"
	@git branch -M main 2>/dev/null || true
	@git push -u origin main --force
	@echo "✅ Published! View at: https://light-merlin-dark.github.io/public/"
	@echo "⏳ Note: GitHub Pages may take a few minutes to update"

# One-time setup for GitHub Pages
setup:
	@echo "🔧 Setting up GitHub Pages..."
	@gh repo edit --enable-pages --pages-branch main || echo "Pages might already be enabled"
	@echo "✅ GitHub Pages configured!"
	@echo "🌐 Your site will be available at: https://light-merlin-dark.github.io/public/"

# Check deployment status
status:
	@echo "📊 Checking GitHub Pages status..."
	@gh pages status || echo "GitHub Pages not yet configured. Run 'make setup' first."

# Local preview server
serve:
	@echo "🚀 Starting local preview server..."
	@echo "📍 Visit http://localhost:8000"
	@python3 -m http.server 8000 || python -m SimpleHTTPServer 8000

# Clean generated files (if any)
clean:
	@echo "🧹 Cleaning temporary files..."
	@find . -name ".DS_Store" -delete 2>/dev/null || true
	@echo "✅ Cleaned!"

# Quick commit and push
quick:
	@git add -A && git commit -m "Quick update" && git push origin main

# Add new content from parent ai folder
sync-content:
	@echo "📋 Syncing content from ai/statistics-humor-enhancement..."
	@cp ../ai/statistics-humor-enhancement/content-example.md statistics-teaching-enhancement.md
	@echo "✅ Content synced!"