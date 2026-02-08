#!/usr/bin/env bash

GETH_ADDR="localhost"
GETH_METRICS_PORT="6060"
GETH_METRICS_URL="http://${GETH_ADDR}:${GETH_METRICS_PORT}"
GETH_RPC_PORT="8545"
GETH_RPC_URL="http://${GETH_ADDR}:${GETH_RPC_PORT}"

NIMBUS_BEACON_ADDR="localhost"
NIMBUS_BEACON_METRICS_PORT="5054"
NIMBUS_BEACON_METRICS_URL="http://${NIMBUS_BEACON_ADDR}:${NIMBUS_BEACON_METRICS_PORT}"
#NIMBUS_BEACON_REST_PORT="5052"
#NIMBUS_BEACON_REST_URL="http://${NIMBUS_BEACON_REST_ADDR}:${NIMBUS_BEACON_REST_PORT}"

echo nimbus-beacon metrics:
curl --silent "${NIMBUS_BEACON_METRICS_URL}/metrics" | grep -v "#" | grep \
	-e "beacon_slot " \
	-e "beacon_head_slot " \
	-e "engine_api_responses_total" \
	-e "nbc_peers " \
	-e "beacon_attestations_received_total" \
	-e "beacon_attestations_sent_total" \
	-e "^version{" \
	| sort

# https://github.com/status-im/beacon-APIs/blob/master/beacon-node-oapi.yaml
#echo nimbus-beacon rest api:
#curl --silent http://localhost:5052/eth/v1/node/version | jq
#curl --silent http://localhost:5052/eth/v1/node/syncing | jq
#curl --silent http://localhost:5052/eth/v1/node/peer_count | jq

echo
echo geth metrics:
curl --silent "${GETH_METRICS_URL}/debug/metrics/prometheus" | grep -v "#" | grep \
	-e "p2p_peers " \
	-e "chain_head_block "

echo
echo geth rpc:
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}' \
	-H "Content-Type: application/json" \
	"${GETH_RPC_URL}"
