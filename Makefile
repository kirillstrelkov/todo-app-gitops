all: argocd

encrypt:
	@PUBKEY=$$(grep '# public key:' ./key.txt | cut -d ':' -f 2 | tr -d ' ') ; \
	sops --encrypt --age $$PUBKEY --encrypted-regex '(stringData)' ./dec/secrets-prod.yaml > ./overlays/production/secrets.yaml && \
	sops --encrypt --age $$PUBKEY --encrypted-regex '(stringData)' ./dec/secrets-staging.yaml > ./overlays/staging/secrets.yaml

decrypt:
	mkdir -p ./dec/
	export SOPS_AGE_KEY_FILE=./key.txt; \
	sops --decrypt ./overlays/production/secrets.yaml > ./dec/secrets-prod.yaml && \
	sops --decrypt ./overlays/staging/secrets.yaml > ./dec/secrets-staging.yaml

ctx:
	kubectx k3d-k3s-default

argocd: ctx
	kubectl apply -f argocd-apps/production.yaml
	kubectl apply -f argocd-apps/staging.yaml

clean: ctx
	kubectl delete -f argocd-apps/production.yaml || true
	kubectl delete -f argocd-apps/staging.yaml || true
