PYTHON = python
export PYTHONUNBUFFERED := 1

.PHONY: help install install-dev lint typecheck test push notebook

help:
	@echo ""
	@echo "Setup:"
	@echo "  install       Install runtime deps + package (editable)"
	@echo "  install-dev   Also install dev tooling (mypy, ruff, black)"
	@echo ""
	@echo "Quality:"
	@echo "  push          Run typecheck + lint, then git push (only if both pass)"
	@echo "  typecheck     Run mypy over src/"
	@echo "  lint          Run ruff linter"
	@echo "  test          Run test suite"
	@echo ""
	@echo "Analysis:"
	@echo "  notebook      Launch Jupyter in notebooks/"
	@echo ""

# ── Setup ────────────────────────────────────────────────────────────────────

install:
	$(PYTHON) -m pip install -r requirements.txt
	$(PYTHON) -m pip install -e .

install-dev: install
	$(PYTHON) -m pip install -r requirements-dev.txt

# ── Quality ──────────────────────────────────────────────────────────────────

typecheck:
	$(PYTHON) -m mypy src/

lint:
	$(PYTHON) -m ruff check .

test:
	$(PYTHON) -m pytest

push: typecheck lint
	git push

# ── Analysis ─────────────────────────────────────────────────────────────────

notebook:
	$(PYTHON) -m jupyter notebook notebooks/
