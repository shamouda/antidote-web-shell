const config = {
    antidote: [
        {
            host: '127.0.0.1',
            port: 8087
        },
        {
            host: '127.0.0.1',
            port: 8088
        },
        {
            host: '127.0.0.1',
            port: 8089
        }
    ],
    partitionCmd: './net_part.sh'
};

module.exports = config;

