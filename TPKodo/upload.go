package TPKodo

import (
	"bufio"
	"context"
	"encoding/json"
	"flag"
	"fmt"
	"strconv"

	"github.com/qiniupd/qiniu-go-sdk/syncdata/operation"

	"io"
	"log"
	"os"
	"path"
)
var log =var log = logging.Logger("graphsplit/kodo")

func fileList(file string) []string {
	a, err := os.Open(file)
	if err != nil {
		log.Fatalln(err)
	}
	buff := bufio.NewReader(a)
	var ret []string
	l, _, err := buff.ReadLine()
	for ; err == nil; l, _, err = buff.ReadLine() {
		ret = append(ret, string(l))
	}
	return ret
}

func Upload(ctx context.Context,carDir,bucket string) error{
	// cf := flag.String("c", "cfg.toml", "config")
	// f := flag.String("f", "file", "upload file")
	// flag.Parse()
	// ctx:=context.Background()

	// x,err:=operation.Load(*cf)
	// if err!=nil{
	// 	log.Fatalln(err)
	// }

	// up:=operation.NewUploader(x)
	// files:=filesList(*f)
	

}