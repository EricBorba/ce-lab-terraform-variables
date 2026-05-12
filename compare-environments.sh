#!/bin/bash
echo "=== Development Environment ==="
aws s3api get-bucket-versioning --bucket myapp-ericborba-dev-bucket
aws s3api get-bucket-tagging --bucket myapp-ericborba-dev-bucket

echo ""
echo "=== Production Environment ==="
aws s3api get-bucket-versioning --bucket myapp-ericborba-prod-bucket
aws s3api get-bucket-tagging --bucket myapp-ericborba-prod-bucket

echo ""
echo "=== Staging Environment ==="
aws s3api get-bucket-versioning --bucket myapp-ericborba-staging-bucket
aws s3api get-bucket-tagging --bucket myapp-ericborba-staging-bucket