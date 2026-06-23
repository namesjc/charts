{{/*
Expand the name of the chart.
*/}}
{{- define "getting-started-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "getting-started-app.fullname" -}}
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
{{- define "getting-started-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "getting-started-app.labels" -}}
helm.sh/chart: {{ include "getting-started-app.chart" . }}
{{ include "getting-started-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.commonLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "getting-started-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "getting-started-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
App image
*/}}
{{- define "getting-started-app.image" -}}
{{- $registry := .Values.image.registry -}}
{{- if .Values.global.registry -}}
{{- $registry = .Values.global.registry -}}
{{- end -}}
{{- if .Values.image.repository -}}
{{- printf "%s/%s" $registry .Values.image.repository -}}
{{- else -}}
{{- printf "%s" $registry -}}
{{- end -}}
{{- if .Values.image.tag -}}
{{- printf ":%s" .Values.image.tag -}}
{{- else if not .Values.image.digest -}}
{{- printf ":latest" -}}
{{- end -}}
{{- if .Values.image.digest -}}
{{- printf "@%s" .Values.image.digest -}}
{{- end -}}
{{- end -}}

{{/*
Image pull secrets (merge global + local)
*/}}
{{- define "getting-started-app.imagePullSecrets" -}}
{{- $secrets := list -}}
{{- range .Values.global.imagePullSecrets -}}
{{- $secrets = append $secrets . -}}
{{- end -}}
{{- range .Values.imagePullSecrets -}}
{{- $secrets = append $secrets . -}}
{{- end -}}
{{- if $secrets -}}
{{- toYaml $secrets -}}
{{- end -}}
{{- end -}}

{{/*
MySQL fullname
*/}}
{{- define "getting-started-app.mysql.fullname" -}}
{{- printf "%s-mysql" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Database host
*/}}
{{- define "getting-started-app.databaseHost" -}}
{{- if .Values.mysql.enabled -}}
{{- include "getting-started-app.mysql.fullname" . -}}
{{- else -}}
{{- .Values.externalDatabase.host -}}
{{- end -}}
{{- end -}}

{{/*
Database port
*/}}
{{- define "getting-started-app.databasePort" -}}
{{- if .Values.mysql.enabled -}}
3306
{{- else -}}
{{- .Values.externalDatabase.port | int -}}
{{- end -}}
{{- end -}}

{{/*
Database name
*/}}
{{- define "getting-started-app.databaseName" -}}
{{- if .Values.mysql.enabled -}}
{{- .Values.mysql.auth.database -}}
{{- else -}}
{{- .Values.externalDatabase.database -}}
{{- end -}}
{{- end -}}

{{/*
Database user
*/}}
{{- define "getting-started-app.databaseUser" -}}
{{- if .Values.mysql.enabled -}}
{{- .Values.mysql.auth.username -}}
{{- else -}}
{{- .Values.externalDatabase.user -}}
{{- end -}}
{{- end -}}

{{/*
MySQL secret name
*/}}
{{- define "getting-started-app.mysql.secretName" -}}
{{- if .Values.mysql.enabled -}}
{{- if .Values.mysql.auth.existingSecret -}}
{{- .Values.mysql.auth.existingSecret -}}
{{- else -}}
{{- include "getting-started-app.mysql.fullname" . -}}
{{- end -}}
{{- else if .Values.externalDatabase.existingSecret -}}
{{- .Values.externalDatabase.existingSecret -}}
{{- else -}}
{{- printf "%s-external-db" (include "getting-started-app.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
MySQL password secret key
*/}}
{{- define "getting-started-app.mysql.secretPasswordKey" -}}
{{- if .Values.mysql.enabled -}}
{{- if .Values.mysql.auth.existingSecretPasswordKey -}}
{{- .Values.mysql.auth.existingSecretPasswordKey -}}
{{- else -}}
mysql-password
{{- end -}}
{{- else if .Values.externalDatabase.existingSecretPasswordKey -}}
{{- .Values.externalDatabase.existingSecretPasswordKey -}}
{{- else -}}
mysql-password
{{- end -}}
{{- end -}}

{{/*
MySQL root password secret key
*/}}
{{- define "getting-started-app.mysql.secretRootPasswordKey" -}}
{{- if .Values.mysql.enabled -}}
{{- if .Values.mysql.auth.existingSecretRootPasswordKey -}}
{{- .Values.mysql.auth.existingSecretRootPasswordKey -}}
{{- else -}}
mysql-root-password
{{- end -}}
{{- else -}}
mysql-root-password
{{- end -}}
{{- end -}}
