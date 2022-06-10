{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "qumine.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "qumine.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "qumine.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Helm required labels */}}
{{- define "qumine.labels" -}}
helm.sh/chart: {{ template "qumine.chart" . }}
app.kubernetes.io/name: {{ template "qumine.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.labels }}
{{ toYaml .Values.labels }}
{{- end }}
{{- end -}}

{{/* annotations */}}
{{- define "qumine.annotations" -}}
{{- if .Values.annotations }}
{{ toYaml .Values.annotations }}
{{- end }}
{{- end -}}

{{/* matchLabels */}}
{{- define "qumine.matchLabels" -}}
app.kubernetes.io/name: {{ template "qumine.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* Helm required labels */}}
{{- define "qumine.podLabels" -}}
helm.sh/chart: {{ template "qumine.chart" . }}
app.kubernetes.io/name: {{ template "qumine.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.podLabels }}
{{ toYaml .Values.podLabels }}
{{- end }}
{{- end -}}

{{/* podAnnotations */}}
{{- define "qumine.podAnnotations" -}}
{{- if .Values.podAnnotations }}
{{ toYaml .Values.podAnnotations }}
{{- end }}
{{- if .Values.integrations.metrics.podAnnotations }}
{{ toYaml .Values.integrations.metrics.podAnnotations }}
{{- end }}
{{- end -}}

{{/* serviceAnnotations */}}
{{- define "qumine.serviceAnnotations" -}}
{{- if .Values.service.annotations }}
{{ toYaml .Values.service.annotations }}
{{- end }}
{{- if .Values.integrations.qumineIngress.enabled }}
ingress.qumine.io/hostname: {{ .Values.integrations.qumineIngress.hostname | quote}}
{{- end }}
{{- end -}}

{{/*
Return the proper  image name
*/}}
{{- define "qumine.image" -}}
{{- $registryName := .Values.image.registry -}}
{{- $repositoryName := .Values.image.repository -}}
{{- $tag := .Values.image.tag | toString -}}
{{/*
Helm 2.11 supports the assignment of a value to a variable defined in a different scope,
but Helm 2.9 and 2.10 doesn't support it, so we need to implement this if-else logic.
Also, we can't use a single if because lazy evaluation is not an option
*/}}
{{- if .Values.global }}
    {{- if .Values.global.imageRegistry }}
        {{- printf "%s/%s:%s" .Values.global.imageRegistry $repositoryName $tag -}}
    {{- else -}}
        {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
    {{- end -}}
{{- else -}}
    {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "qumine.imagePullSecrets" -}}
{{/*
Helm 2.11 supports the assignment of a value to a variable defined in a different scope,
but Helm 2.9 and 2.10 does not support it, so we need to implement this if-else logic.
Also, we can not use a single if because lazy evaluation is not an option
*/}}
{{- if .Values.global }}
{{- if .Values.global.imagePullSecrets }}
imagePullSecrets:
{{- range .Values.global.imagePullSecrets }}
  - name: {{ . }}
{{- end }}
{{- else if .Values.image.pullSecrets }}
imagePullSecrets:
{{- range .Values.image.pullSecrets }}
  - name: {{ . }}
{{- end }}
{{- end -}}
{{- else if .Values.image.pullSecrets }}
imagePullSecrets:
{{- range .Values.image.pullSecrets }}
  - name: {{ . }}
{{- end }}
{{- end -}}
{{- end -}}


{{- define "qumine.additionalFiles" -}}
{{- print (join "," .Values.additionalFiles) -}}
{{- end -}}

{{- define "qumine.plugins" -}}
{{- $plugins := join "," .Values.plugins -}}
{{- if .Values.integrations.metrics.enabled }}
{{- $plugins = print "https://github.com/sladkoff/minecraft-prometheus-exporter/releases/download/v2.4.2/minecraft-prometheus-exporter-2.4.2.jar," $plugins -}}
{{- end}}
{{- print $plugins -}}
{{- end -}}

{{/*
Return the proper bluemap DNS image name
*/}}
{{- define "qumine.integrations.bluemap.image" -}}
{{- $registryName := .Values.integrations.bluemap.image.registry -}}
{{- $repositoryName := .Values.integrations.bluemap.image.repository -}}
{{- $tag := .Values.integrations.bluemap.image.tag | toString -}}
{{/*
Helm 2.11 supports the assignment of a value to a variable defined in a different scope,
but Helm 2.9 and 2.10 doesn't support it, so we need to implement this if-else logic.
Also, we can't use a single if because lazy evaluation is not an option
*/}}
{{- if .Values.global }}
    {{- if .Values.global.imageRegistry }}
        {{- printf "%s/%s:%s" .Values.global.imageRegistry $repositoryName $tag -}}
    {{- else -}}
        {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
    {{- end -}}
{{- else -}}
    {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper GeyserMC image name
*/}}
{{- define "qumine.integrations.geysermc.image" -}}
{{- $registryName := .Values.integrations.geysermc.image.registry -}}
{{- $repositoryName := .Values.integrations.geysermc.image.repository -}}
{{- $tag := .Values.integrations.geysermc.image.tag | toString -}}
{{/*
Helm 2.11 supports the assignment of a value to a variable defined in a different scope,
but Helm 2.9 and 2.10 doesn't support it, so we need to implement this if-else logic.
Also, we can't use a single if because lazy evaluation is not an option
*/}}
{{- if .Values.global }}
    {{- if .Values.global.imageRegistry }}
        {{- printf "%s/%s:%s" .Values.global.imageRegistry $repositoryName $tag -}}
    {{- else -}}
        {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
    {{- end -}}
{{- else -}}
    {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end -}}
{{- end -}}
