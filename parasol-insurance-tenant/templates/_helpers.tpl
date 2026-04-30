{{- define "parasol-insurance-tenant.username" -}}
{{ .Values.tenant.username }}
{{- end -}}

{{- define "parasol-insurance-tenant.prefix" -}}
{{ .Values.tenant.username }}-parasol-insurance
{{- end -}}

{{- define "tenant.gitlabGroup" -}}
tenant-{{ .Values.tenant.username }}
{{- end -}}

{{- define "tenant.quayOrg" -}}
tenant-{{ .Values.tenant.username }}
{{- end -}}

{{- define "tenant.appProjectName" -}}
tenant-{{ .Values.tenant.username }}
{{- end -}}

{{- define "tenant.vaultPolicyName" -}}
tenant-{{ .Values.tenant.username }}
{{- end -}}

{{- define "tenant.vaultK8sRoleName" -}}
tenant-{{ .Values.tenant.username }}
{{- end -}}

{{- define "tenant.vaultPathPrefix" -}}
kv/secrets/tenants/{{ .Values.tenant.username }}
{{- end -}}

{{- define "tenant.webhookListenerHost" -}}
{{ .Values.tenant.username }}-parasol-pipeline.{{ .Values.cluster.subdomain }}
{{- end -}}

{{- define "tenant.validate" -}}
{{- $u := .Values.tenant.username -}}
{{- if not $u -}}
{{- fail "tenant.username is required" -}}
{{- end -}}
{{- if not (regexMatch "^[a-z][a-z0-9]{1,15}$" $u) -}}
{{- fail (printf "tenant.username %q must match ^[a-z][a-z0-9]{1,15}$ (lowercase, leading letter, 2-16 chars)" $u) -}}
{{- end -}}
{{- $reserved := list "vault" "keycloak" "gitlab" "quay" "rhdh-gitops" "noobaa" "external-secrets" "default" "parasol" "parasol-insurance" "tenant" -}}
{{- if has $u $reserved -}}
{{- fail (printf "tenant.username %q is a reserved platform name" $u) -}}
{{- end -}}
{{- if or (hasPrefix "kube-" $u) (hasPrefix "openshift-" $u) -}}
{{- fail (printf "tenant.username %q must not start with kube- or openshift-" $u) -}}
{{- end -}}
{{- end -}}
