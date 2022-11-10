package graphsplit

import (
	"bufio"
	"context"

	"os"
)

func fileList(file string) []string {
	a, err := os.Open(file)
	if err != nil {
		log.Fatalf(err.Error())
	}
	buff := bufio.NewReader(a)
	var ret []string
	l, _, err := buff.ReadLine()
	for ; err == nil; l, _, err = buff.ReadLine() {
		ret = append(ret, string(l))
	}
	return ret
}

func Upload(ctx context.Context, carDir, bucket string) error {

	return nil
}
