//------------------------------------------------------------------------------
// File Name   : Cb_Token.cs
// Creator     : Moses.Zhu
// Create Date : 2017-03-09
// Description : 此代码由工具生成，请不要人为更改代码，如果重新生成代码后，这些更改将会丢失。
// Copyright (C) 2017 Qisda Corporation. All rights reserved.
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using ITS.Data;
using ITS.Data.Common;

namespace Cube.Model.Entity
{

    /// <summary>
    /// 实体类Cb_Token
    /// </summary>
    [Serializable]
    public class Cb_Token : ITS.Data.EntityBase
    {
        public Cb_Token() : base("cb_token") { }

        #region Model
        private Guid _User_Id;
        private DateTime _Login_Time;
        private string _Token;
        /// <summary>
        /// 
        /// </summary>
        public Guid User_Id
        {
            get { return _User_Id; }
            set
            {
                this.OnPropertyValueChange(_.User_Id, _User_Id, value);
                this._User_Id = value;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime Login_Time
        {
            get { return _Login_Time; }
            set
            {
                this.OnPropertyValueChange(_.Login_Time, _Login_Time, value);
                this._Login_Time = value;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        public string Token
        {
            get { return _Token; }
            set
            {
                this.OnPropertyValueChange(_.Token, _Token, value);
                this._Token = value;
            }
        }
        #endregion

        #region Method
        /// <summary>
        /// 获取实体中的主键列
        /// </summary>
        public override Field[] GetPrimaryKeyFields()
        {
            return new Field[] {
				_.User_Id};
        }
        /// <summary>
        /// 获取列信息
        /// </summary>
        public override Field[] GetFields()
        {
            return new Field[] {
				_.User_Id,
				_.Login_Time,
				_.Token};
        }
        /// <summary>
        /// 获取值信息
        /// </summary>
        public override object[] GetValues()
        {
            return new object[] {
				this._User_Id,
				this._Login_Time,
				this._Token};
        }
        /// <summary>
        /// 给当前实体赋值
        /// </summary>
        public override void SetPropertyValues(IDataReader reader)
        {
            this._User_Id = DataUtils.ConvertValue<Guid>(reader["user_id"]);
            this._Login_Time = DataUtils.ConvertValue<DateTime>(reader["login_time"]);
            this._Token = DataUtils.ConvertValue<string>(reader["token"]);
        }
        /// <summary>
        /// 给当前实体赋值
        /// </summary>
        public override void SetPropertyValues(DataRow row)
        {
            this._User_Id = DataUtils.ConvertValue<Guid>(row["user_id"]);
            this._Login_Time = DataUtils.ConvertValue<DateTime>(row["login_time"]);
            this._Token = DataUtils.ConvertValue<string>(row["token"]);
        }
        #endregion

        #region _Field
        /// <summary>
        /// 字段信息
        /// </summary>
        public class _
        {
            /// <summary>
            /// * 
            /// </summary>
            public readonly static Field All = new Field("*", "cb_token");
            /// <summary>
            /// 
            /// </summary>
            public readonly static Field User_Id = new Field("user_id", "cb_token", DbType.Guid, 16, "user_id");
            /// <summary>
            /// 
            /// </summary>
            public readonly static Field Login_Time = new Field("login_time", "cb_token", DbType.DateTime, 8, "login_time");
            /// <summary>
            /// 
            /// </summary>
            public readonly static Field Token = new Field("token", "cb_token", DbType.String, 100, "token");
        }
        #endregion


    }
}

