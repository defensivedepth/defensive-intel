#Quick setup, requires sudo

mkdir /nsm/defensive-intel

echo "Copying over files & restarting Elastic Fleet & Elasticsearch..."

cp files/final_ingest_pipeline.json /opt/so/saltstack/default/salt/elasticsearch/files/ingest/.fleet_final_pipeline-1

cp files/integration_ingest/* /opt /opt/so/saltstack/default/salt/elasticfleet/files/integrations/grid-nodes_general/

so-elastic-fleet-restart --force

salt-call state.apply elasticsearch

echo "Building the Defensive Intel container"

docker build --network=host -t so-defensive-intel:poc .

echo "Invoke container: docker run  --network=host --rm -it --mount type=bind,source=/nsm/defensive-intel/,target=/nsm/defensive-intel/ so-defensive-intel:poc /bin/bash"