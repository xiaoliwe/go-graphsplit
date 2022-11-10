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

type CsvRowData struct {
	PayloadCID  string
	Filename    string
	URL         string
	PieceCID    string
	PayloadSize string
	PieceSize   string
}

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
	records := readCsvFile(carDir + "manifest.csv")
	fmt.Printf("----The row count is : %v\n ------", len(records))

	for _, line := range records {
		item := CsvRowData{
			PayloadCID:  line[0],
			Filename:    line[1],
			URL:         line[2],
			PieceCID:    line[3],
			PayloadSize: line[4],
			PieceSize:   line[5],
		}
		fmt.Println("The car filename is:" + carDir + item.PayloadCID + ".car")
	}

	return nil
}
