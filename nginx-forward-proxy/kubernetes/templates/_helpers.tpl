{{/*
Expand the name of the chart.
*/}}
{{- define "nginx-forward-proxy.fullname" -}}
{{- printf "%s" .Release.Name -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "nginx-forward-proxy.labels" -}}
app.kubernetes.io/name: {{ include "nginx-forward-proxy.fullname" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | quote }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "nginx-forward-proxy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nginx-forward-proxy.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}