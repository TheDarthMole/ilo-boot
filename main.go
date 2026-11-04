package main

import (
	"context"
	"os"

	"github.com/labstack/echo/v5"
	"github.com/labstack/echo/v5/middleware"
)

func main() {
	e := echo.New()
	e.Use(middleware.RequestLogger())
	e.StaticFS("/", os.DirFS("public"), setMIMEHeadersMiddleware)

	sc := echo.StartConfig{Address: ":8000"}
	if err := sc.Start(context.Background(), e); err != nil {
		e.Logger.Error("failed to start server", "error", err)
	}
}

func setMIMEHeadersMiddleware(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c *echo.Context) error {
		c.Response().Header().Set(echo.HeaderContentType, echo.MIMEOctetStream)

		err := next(c)
		return err
	}
}
