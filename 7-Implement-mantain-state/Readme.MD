>  **Pasos para habilitar Vault**:  
> 
> 
1. Crear la cuenta en hashiscorp
2. Crear cluster de consul
3. Habilitar el acceso public
4. crear un Key/value  ejemplo : tf

> **Conexiones**: 
5. url de ingreso : 
5. Generar token para ingreso 

> **variables de entorno**:
export CONSUL_HTTP_TOKEN={toke_generado_por_consul}
export CONSUL_HTTP_ADDR=https://{url_acceso_cluster_consul}
export CONSUL_HTTP_SSL=true

> **Usando como parametro de entrada un archivo**:
terraform init -backend-config=./conn.conf

