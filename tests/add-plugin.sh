# Create plugin
curl -i -X POST \
--url http://localhost:8001/services/crud/plugins \
--data 'name=request-transformer' \
--data 'config.add.headers=Authorization:Basic U3VwZXJVc2VyOlNZUw==' \
--data 'config.replace.headers=Authorization:Basic U3VwZXJVc2VyOlNZUw=='

