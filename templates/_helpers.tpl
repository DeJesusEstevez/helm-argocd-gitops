{{/*
Nombre del chart, recortado a 63 caracteres (límite de las etiquetas de Kubernetes).
*/}}
{{- define "intec-web.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Nombre de los recursos. Si el release ya contiene el nombre del chart (como
«intec-web»), se usa tal cual para no repetirlo.
*/}}
{{- define "intec-web.fullname" -}}
{{- if contains .Chart.Name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Etiquetas comunes recomendadas por Kubernetes.
*/}}
{{- define "intec-web.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" }}
{{ include "intec-web.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Etiquetas que identifican los pods (selector del Deployment y del Service).
*/}}
{{- define "intec-web.selectorLabels" -}}
app.kubernetes.io/name: {{ include "intec-web.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
