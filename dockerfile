# Use the official qBittorrent image as the base
FROM linuxserver/qbittorrent:latest

# Download and extract the Dracula qBittorrent web UI files
RUN cd /opt && curl -L -o master.zip https://github.com/dracula/qbittorrent/archive/refs/heads/master.zip && unzip master.zip && mv qbittorrent-master qbittorrent && rm master.zip

# Copy the web UI files to the qBittorrent web UI directory
RUN cp -r /opt/qbittorrent/webui/* /usr/share/qbittorrent/nox/webui/

# Ensure the web UI is set to the correct location in the config files
RUN sed -i 's|^WebUI\/RootFolder=.*|WebUI/RootFolder=/usr/share/qbittorrent/nox/webui|' /config/qBittorrent.conf

# Expose the necessary ports
EXPOSE 8080

# Start qBittorrent
CMD ["/usr/bin/qbittorrent-nox", "--webui-port=8080"]