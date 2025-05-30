{{/*
Expand the name of the chart.
*/}}
{{- define "redash.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "redash.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "redash.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "redash.labels" -}}
helm.sh/chart: {{ include "redash.chart" . }}
{{ include "redash.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "redash.selectorLabels" -}}
app.kubernetes.io/name: {{ include "redash.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "redash.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "redash.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the PostgreSQL hostname
*/}}
{{- define "redash.postgresql.host" -}}
{{- if .Values.postgresql.enabled }}
    {{- printf "%s-postgresql" (include "redash.fullname" .) -}}
{{- else -}}
    {{- .Values.externalPostgresql.host -}}
{{- end -}}
{{- end -}}

{{/*
Return the PostgreSQL port
*/}}
{{- define "redash.postgresql.port" -}}
{{- if .Values.postgresql.enabled }}
    {{- printf "5432" -}}
{{- else -}}
    {{- .Values.externalPostgresql.port -}}
{{- end -}}
{{- end -}}

{{/*
Return the PostgreSQL database name
*/}}
{{- define "redash.postgresql.database" -}}
{{- if .Values.postgresql.enabled }}
    {{- .Values.postgresql.auth.database -}}
{{- else -}}
    {{- .Values.externalPostgresql.database -}}
{{- end -}}
{{- end -}}

{{/*
Return the PostgreSQL user
*/}}
{{- define "redash.postgresql.user" -}}
{{- if .Values.postgresql.enabled }}
    {{- .Values.postgresql.auth.username -}}
{{- else -}}
    {{- .Values.externalPostgresql.user -}}
{{- end -}}
{{- end -}}

{{/*
Return the PostgreSQL password secret name
*/}}
{{- define "redash.postgresql.secretName" -}}
{{- if .Values.postgresql.enabled }}
    {{- printf "%s-postgresql" (include "redash.fullname" .) -}}
{{- else -}}
    {{- default (printf "%s-external-postgresql" (include "redash.fullname" .)) .Values.externalPostgresql.existingSecret -}}
{{- end -}}
{{- end -}}

{{/*
Return the Redis hostname
*/}}
{{- define "redash.redis.host" -}}
{{- if .Values.redis.enabled }}
    {{- printf "%s-redis-master" (include "redash.fullname" .) -}}
{{- else -}}
    {{- .Values.externalRedis.host -}}
{{- end -}}
{{- end -}}

{{/*
Return the Redis port
*/}}
{{- define "redash.redis.port" -}}
{{- if .Values.redis.enabled }}
    {{- printf "6379" -}}
{{- else -}}
    {{- .Values.externalRedis.port -}}
{{- end -}}
{{- end -}}

{{/*
Return the Redis password secret name
*/}}
{{- define "redash.redis.secretName" -}}
{{- if .Values.redis.enabled }}
    {{- printf "%s-redis" (include "redash.fullname" .) -}}
{{- else -}}
    {{- default (printf "%s-external-redis" (include "redash.fullname" .)) .Values.externalRedis.existingSecret -}}
{{- end -}}
{{- end -}}
