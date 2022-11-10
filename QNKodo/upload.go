package kodo

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

func Upload(ctx context.Context,carDir,bucket string) error{
	
}