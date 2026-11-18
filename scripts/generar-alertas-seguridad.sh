#!/bin/bash
set -euo pipefail

URL="http://localhost:5000"

echo "=========================================================="
echo "  SIMULACIÓN DE TRÁFICO ANÓMALO (TP12C)"
echo "=========================================================="
echo "Objetivo: $URL"
echo ""

echo "[1/2] Generando escaneo de rutas inexistentes (HTTP 404)..."
for i in {1..40}; do
  curl -s -o /dev/null -w "%{http_code}\n" "$URL/api/v1/ruta-inexistente-$i" || true
done

echo ""
echo "[2/2] Simulando fallos de autenticación (HTTP 401)..."
for i in {1..30}; do
  curl -s -o /dev/null -w "%{http_code}\n" -X POST "$URL/login" -H "Content-Type: application/json" -d '{"user":"admin","pass":"wrong"}' || true
done

echo ""
echo "=== Simulación completada ==="
