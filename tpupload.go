package graphsplit

import (
	"bufio"
	"context"
	"encoding/csv"
	"flag"
	"fmt"

	"os"

	"github.com/qiniupd/qiniu-go-sdk/syncdata/operation"
)

func readCsvFile(filePath string) [][]string {
	f, err := os.Open(filePath)
	if err != nil {
		log.Fatal("Unable to read input file "+filePath, err)
	}
	defer f.Close()

	csvReader := csv.NewReader(f)
	records, err := csvReader.ReadAll()
	if err != nil {
		log.Fatal("Unable to parse file as CSV for "+filePath, err)
	}

	return records
}

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

func Upload(ctx context.Context, carDir string) error {
	cf := flag.String("c", "cfg.toml", "config")
	flag.Parse()

	cnf, err := operation.Load(*cf)
	if err != nil {
		log.Fatal(err)
	}

	up := operation.NewUploader(cnf)
	fmt.Println(up)

	//Get the manifest.csv and read CID of file.
	records := readCsvFile("../17GData/manifest.csv")
	fmt.Println(len(records))

	for _, value := range records {
		fmt.Println(" %v\n", value)
	}

	//Join the car file's path , like : /disk/17GData/xxxxxx.car

	//upload the car file to kodo

	return nil
}
