import sys

if __name__ == "__main__":
    f_bin = open(str(sys.argv[1]), "rb")
    f_hex = open(str(sys.argv[2]), "w")
    while True:
        buf = f_bin.read(4)
        buf_len = len(buf)
        if buf_len > 0:
            s_hex = ''
            s_hex += hex(buf[3])[2:].zfill(2) + hex(buf[2])[2:].zfill(2) + hex(buf[1])[2:].zfill(2) + hex(buf[0])[2:].zfill(2)
            f_hex.write(s_hex + '\n')
        else:
            break