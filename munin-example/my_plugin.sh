#!/bin/sh

output_config() {
    echo "graph_title Example graph"
    echo "plugins.label Values right now"
}

output_values() {
    printf "plugins.value %d\n" $(count_txt_value)
}

count_tx_value() {
    psql -U postgres -d tf_idf -c "SELECT SUM(value) AS total, tx_type FROM heap_table GROUP BY tx_type"
}

output_usage() {
    printf >&2 "%s - munin plugin to graph an example value\n" ${0##*/}
    printf >&2 "Usage: %s [config]\n" ${0##*/}
}

case $# in
    0)
        output_values
        ;;
    1)
        case $1 in
            config)
                output_config
                ;;
            *)
                output_usage
                exit 1
                ;;
        esac
        ;;
    *)
        output_usage
        exit 1
        ;;
esac
