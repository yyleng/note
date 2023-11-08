import paramiko
import os
import sys

import time
import matplotlib.pyplot as plt
import re

if len(sys.argv) != 7:
    print(
        f"Usage: python {sys.argv[0]} [server_address] [user] [password] [port] [remote file] [col]")
    exit(-1)

# 远程服务器信息
hostname = sys.argv[1]
port = int(sys.argv[4])
username = sys.argv[2]
password = sys.argv[3]  # 或者使用密钥进行认证
col = int(sys.argv[6])

# 远程文件路径和本地文件路径
remote_file_path = sys.argv[5]
local_file_path = os.path.basename(remote_file_path)
graph_label = os.path.splitext(local_file_path)[0]
print(f"remote_file_path: {remote_file_path}")

print(f"local_file_path: {local_file_path}")

print(f"graph_label: {graph_label}")

# 创建 SSH 客户端对象
ssh_client = paramiko.SSHClient()

# 连接到远程服务器
ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

while True:
    try:
        ssh_client.connect(hostname, port, username, password)

        # 创建 SFTP 客户端
        sftp = ssh_client.open_sftp()

        # 从远程服务器下载文件到本地
        sftp.get(remote_file_path, local_file_path)

        # 关闭 SFTP 客户端和 SSH 连接
        sftp.close()
        ssh_client.close()

        print(
            f'File downloaded from {hostname}:{remote_file_path} to {local_file_path}')

        mem_array = []
        with open(local_file_path, "rt") as f:
            lines = f.readlines()
            i = 0
            for line in lines:
                if i < 3:
                    i += 1
                    continue
                if not line.strip():
                    continue
                line = re.sub(r"\s+", " ", line)
                content = line.split(' ')
                if content[col] == 'RSS':
                    continue
                mem = int(content[col])
                mem_array.append(mem)

        plt.plot(range(len(mem_array)), mem_array, 'bo--',
                 alpha=0.5, linewidth=1, label=graph_label)
        plt.legend()  # 显示上面的label
        plt.xlabel('time')  # x_label
        plt.ylabel('number')  # y_label

        # plt.show()
        plt.pause(10)
        plt.close()
    except Exception as e:
        print(f'Error: {str(e)}')
        time.sleep(30)
