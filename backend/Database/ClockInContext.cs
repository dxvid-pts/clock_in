﻿using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using backend.Models;

namespace backend.Database;

// build command
// dotnet ef dbcontext scaffold Name=ConnectionStrings:Database Pomelo.EntityFrameworkCore.MySql --context-dir "Database" --output-dir "Models"

public partial class ClockInContext : DbContext
{
    public ClockInContext()
    {
    }

    public ClockInContext(DbContextOptions<ClockInContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Account> Accounts { get; set; }

    public virtual DbSet<ManagerEmployee> ManagerEmployees { get; set; }

    public virtual DbSet<Token> Tokens { get; set; }

    public virtual DbSet<Work> Works { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseMySql("name=ConnectionStrings:Database", Microsoft.EntityFrameworkCore.ServerVersion.Parse("10.11.2-mariadb"));

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .UseCollation("utf8mb4_general_ci")
            .HasCharSet("utf8mb4");

        modelBuilder.Entity<Account>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("account");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.Blocked).HasColumnName("blocked");
            entity.Property(e => e.Email)
                .HasMaxLength(255)
                .HasColumnName("email");
            entity.Property(e => e.LastLogin)
                .HasColumnType("datetime")
                .HasColumnName("last_login");
            entity.Property(e => e.Password)
                .HasMaxLength(255)
                .HasColumnName("password");
            entity.Property(e => e.Role)
                .HasColumnType("enum('ADMIN','MANAGER','EMPLOYEE')")
                .HasColumnName("role");
        });

        modelBuilder.Entity<ManagerEmployee>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("manager_employee");

            entity.HasIndex(e => e.EmployeeId, "employee_id");

            entity.HasIndex(e => e.ManagerId, "manager_id");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.EmployeeId)
                .HasColumnType("int(11)")
                .HasColumnName("employee_id");
            entity.Property(e => e.ManagerId)
                .HasColumnType("int(11)")
                .HasColumnName("manager_id");

            entity.HasOne(d => d.Employee).WithMany(p => p.ManagerEmployeeEmployees)
                .HasForeignKey(d => d.EmployeeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("manager_employee_ibfk_2");

            entity.HasOne(d => d.Manager).WithMany(p => p.ManagerEmployeeManagers)
                .HasForeignKey(d => d.ManagerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("manager_employee_ibfk_1");
        });

        modelBuilder.Entity<Token>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("token");

            entity.HasIndex(e => e.AccountId, "account_id");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.AccountId)
                .HasColumnType("int(11)")
                .HasColumnName("account_id");
            entity.Property(e => e.Content)
                .HasMaxLength(511)
                .HasColumnName("content");
            entity.Property(e => e.Expiration)
                .HasColumnType("datetime")
                .HasColumnName("expiration");

            entity.HasOne(d => d.Account).WithMany(p => p.Tokens)
                .HasForeignKey(d => d.AccountId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("token_ibfk_1");
        });

        modelBuilder.Entity<Work>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("work");

            entity.HasIndex(e => e.AccountId, "account_id");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.AccountId)
                .HasColumnType("int(11)")
                .HasColumnName("account_id");
            entity.Property(e => e.Begin)
                .HasColumnType("datetime")
                .HasColumnName("begin");
            entity.Property(e => e.Changed).HasColumnName("changed");
            entity.Property(e => e.End)
                .HasColumnType("datetime")
                .HasColumnName("end");

            entity.HasOne(d => d.Account).WithMany(p => p.Works)
                .HasForeignKey(d => d.AccountId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("work_ibfk_1");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}